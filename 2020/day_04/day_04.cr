class Parser
  def parse(filepath : String)
    file = File.read(filepath)
    file.strip.split("\n\n").map do |raw|
      raw_to_passport(raw)
    end
  end

  private def raw_to_passport(raw : String)
    pairs = raw.split(/\s/)
    Passport.new(
      find(pairs, "byr"),
      find(pairs, "iyr"),
      find(pairs, "eyr"),
      find(pairs, "hgt"),
      find(pairs, "hcl"),
      find(pairs, "ecl"),
      find(pairs, "pid"),
      find(pairs, "cid")
    )
  end

  private def find(pairs : Array(String), key : String)
    vals = pairs.select{|pair| pair.includes?("#{key}:")}
    return "" if vals.size == 0
    
    vals.first.split(":").last
  end
end

class Passport
  property byr : String
  property iyr : String
  property eyr : String
  property hgt : String
  property hcl : String
  property ecl : String
  property pid : String
  property cid : String

  def initialize(@byr, @iyr, @eyr, @hgt, @hcl, @ecl, @pid, @cid)
  end

  def has_required_fields?
    [byr, iyr, eyr, hgt, hcl, ecl, pid].all? do |attr|
      attr != ""
    end
  end

  def valid?
    (byr.to_i >= 1920 && byr.to_i <= 2002) &&
    (iyr.to_i >= 2010 && iyr.to_i <= 2020) &&
    (eyr.to_i >= 2020 && eyr.to_i <= 2030) &&
    valid_height? &&
    valid_hair? &&
    valid_eyes? &&
    valid_pid?
  end

  private def valid_height?
    md = /^([0-9]+)(cm|in)$/.match(hgt)
    return false unless md

    if md[2]? == "cm"
      md[1].to_i >= 150 && md[1].to_i <= 193
    elsif md[2]? == "in"
      md[1].to_i >= 59 && md[1].to_i <= 76
    else
      false
    end
  end

  private def valid_hair?
    !!/^#[0-9a-f]{6}$/.match(hcl)
  end

  private def valid_eyes?
    ecl.size == 3 &&
    ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].includes?(ecl)
  end

  private def valid_pid?
    !!/^[0-9]{9}$/.match(pid)
  end
end

passports = Parser.new.parse("input.txt")
puts "Part 1: #{passports.count {|p| p.has_required_fields?}}"
puts "Part 2: #{passports.count {|p| p.has_required_fields? && p.valid?}}"