var assert=require("assert")

describe("Users", function (){
  describe("Validation", function (){
    it("validates an email address");
    it("validates the presence of a name");
    it("validates the password");
    // and more
  });

  describe("Storage", function (){
    it("stores an user");
    it("retrieves an user by id");
    it("finds users by email");
    it("updates user details");
    it("just a sample", function(){
      assert(true);
    });
    it("another sample", function(){
      assert(1==1);
    });    
    it("sample 3", function(){
      assert(false);
    });
    it("whatever", function(){
      assert(1==2);
    });
    // and more
  });
});

