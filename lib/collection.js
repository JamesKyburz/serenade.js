(function() {
  var Monkey;

  Monkey = require('./monkey').Monkey;

  Monkey.Collection = (function() {

    Collection.prototype.collection = true;

    Monkey.extend(Collection.prototype, Monkey.Events);

    function Collection(list) {
      var _this = this;
      this.list = list;
      this.length = this.list.length;
      this.bind("change", function() {
        return _this.length = _this.list.length;
      });
    }

    Collection.prototype.get = function(index) {
      return this.list[index];
    };

    Collection.prototype.set = function(index, value) {
      this.list[index] = value;
      this.trigger("change:" + index);
      return this.trigger("change");
    };

    Collection.prototype.push = function(element) {
      this.list.push(element);
      this.trigger("add");
      return this.trigger("change");
    };

    Collection.prototype.update = function(list) {
      this.list = list;
      this.trigger("update");
      return this.trigger("change");
    };

    Collection.prototype.forEach = function(fun) {
      return Monkey.each(this.list, fun);
    };

    return Collection;

  })();

}).call(this);