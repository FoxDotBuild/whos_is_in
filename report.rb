require "pstore"

class Report
  STORAGE = PStore.new("storage.pstore")

  def self.generate(list_of_strings)
      {
          last_udated: Time.now.strftime("%A %r %v"),
          who_is_here: list_of_strings,
          hp: self.hp(list_of_strings)
      }
  end

private

  def self.hp(names)
    STORAGE.transaction do
      STORAGE[:hp] ||= {}
      names.each do |name|
        STORAGE[:hp][name] ||= 0
        STORAGE[:hp][name] += 1        
      end
      STORAGE[:hp]
    end
  end  
end