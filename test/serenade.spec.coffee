require './spec_helper'
{Serenade} = require "../src/serenade"
{expect} = require('chai')

describe "Serenade", ->
  beforeEach -> @setupDom()

  it "can decorate an object with properties", ->
    object = Serenade(name: "Jonas")
    expect(object.name).to.eql("Jonas")
    object.set "name", "Peter"
    expect(object.get("name")).to.eql("Peter")
    expect(-> object.set("name", "John")).to.triggerEvent(object, "change:name")

  describe ".view", ->
    it "registers a view object", ->
      Serenade.view("test", "h1#test")
      @body.append Serenade.render("test", {}, {})
      expect(@body).to.have.element("h1#test")

    it "doesn't require model or controller to be given", ->
      Serenade.view("test", "h1#test")
      @body.append Serenade.render("test")
      expect(@body).to.have.element("h1#test")

    it "can be rendered directly", ->
      @body.append Serenade.view("test", "h1#test").render()
      expect(@body).to.have.element("h1#test")

    it "works fine without a name", ->
      @body.append Serenade.view("h1#test").render()
      expect(@body).to.have.element("h1#test")

    it "can be take models as parameters", ->
      model = { id: 'test' }
      @body.append Serenade.view("test", "h1[id=@id]").render(model)
      expect(@body).to.have.element("h1#test")

    it "can be take controllers as parameters", ->
      tested = false
      controller = { test: -> tested = true }
      model = {}
      @body.append Serenade.view("test", "a[event:click=test]").render(model, controller)
      @fireEvent @body.find('a').get(0), 'click'
      expect(tested).to.be.ok
