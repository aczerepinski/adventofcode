require "spec"
require "../day_04"

describe Parser do
  describe "#parse" do
    it "parses a file" do
      p = Parser.new
      passports = p.parse("test_input.txt")
      passports.size.should eq 4
      passports.first.ecl.should eq "gry"
    end
  end
end

describe Passport do
  describe "#has_required_fields?" do
    it "accepts passport with all required attributes" do
      p = Passport.new("1937", "2017", "2020", "183cm",
        "#fffffd", "gry", "860033327", "147")
      p.has_required_fields?.should be_true
    end 

    it "rejects passport that is missing hgt" do
      p = Passport.new("1929", "2013", "2023", "",
        "#cfa07d", "amb", "028048884", "350")
      p.has_required_fields?.should be_false
    end
  end

  describe "valid?" do
    it "ensures height within allowable range" do
      p = Passport.new("1937", "2017", "2020", "183cm",
        "#fffffd", "gry", "860033327", "147")

      p.valid?.should be_true

      p.hgt = "194cm"
      p.valid?.should be_false
    end

    it "enforces valid eye colors" do
      p = Passport.new("1937", "2017", "2020", "183cm",
        "#fffffd", "gry", "860033327", "147")

      p.valid?.should be_true

      p.ecl = "zzz"
      p.valid?.should be_false
    end

    it "enforces valid hair colors" do
      p = Passport.new("1937", "2017", "2020", "183cm",
        "#fffffd", "gry", "860033327", "147")

      p.valid?.should be_true

      p.hcl = "#fffzfd"
      p.valid?.should be_false

      p.hcl = "#fffffffffd"
      p.valid?.should be_false
    end
  end
end
