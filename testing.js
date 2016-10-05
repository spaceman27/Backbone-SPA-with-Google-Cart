describe("Stat Model has a", function() {
  var sale = new Stat();
  beforeEach(function() {

    sale.set({
      "title": "Sale",
      "value": "Sales",
      "source": function() {}
    })
  })
  it("title property type is text", function() {
    expect(sale.get("title")).toEqual("Sale")
  })
  it("value property type is text", function() {
    expect(sale.get("value")).toEqual("Sales")
  })
})
describe("Select box has", function() {
  var myview;
  beforeEach(function() {
    myview = new SelectList().render();
  })
  it("4 items", function() {
    expect($(".select-chart-stat").children().length).toEqual(4)
  })
})

describe('Router', function() {
  beforeEach( function(){
    Backbone.history.stop();
  })
  it("should call index", function(){
    spyOn(WorkSpace.prototype, "index");
    var router = new WorkSpace();
    Backbone.history.start();
    router.navigate("dashboard/index", true);
    expect(WorkSpace.prototype.index).toHaveBeenCalled();  
  })
});