
module UsingModuleFunction
  module_function

  def public_method1
    "\n   This is a public method one trying to call a private method: #{my_private_method}"
  end

  def public_method2
    "\n   This is public method two"
  end

  private
  def my_private_method
    "\n   my private method is called"
  end
end


module ExtendSelfModule
  extend self

  def public_method1
    "\n   This is a public method one trying to call a private method: #{my_private_method}"
  end

  def public_method2
    "\n   This is public method two"
  end

  private
  def my_private_method
    "\n   my private method is called"
  end
end


class IncludeExtendSelfModule
  include ExtendSelfModule

  def class_call_module_private
    "   Class trying to call module's private method #{my_private_method}"
  end
end

class IncludeModuleFunction
  include UsingModuleFunction

  def class_call_module_private
    "   Class trying to call module's private method #{my_private_method}"
  end
end


run_example = "4"
case run_example
  ###### EXAMPLE 1 #######
  when "1"
    begin
      puts UsingModuleFunction.public_method1
    rescue NameError => e
      puts "Example 1: UsingModuleFunction"
      puts "  I expected an error and got it!"
      puts "  ERROR: #{e.to_s}"
    end

  ###### EXAMPLE 2 #######
  when "2"
    puts "Example 2: Extending Self"
      puts ExtendSelfModule.public_method1


  ###### EXAMPLE 3 #######
  when "3"
    puts "Example 3: "
    puts IncludeExtendSelfModule.new.public_method1


  ###### EXAMPLE 4 #######
  when "4"
    puts "Example 4: "
    puts IncludeExtendSelfModule.new.class_call_module_private
    puts IncludeExtendSelfModule.new.my_private_method

  when "5"
    puts "Example 5: "
    puts IncludeModuleFunction.new.class_call_module_private
    puts IncludeModuleFunction.new.my_private_method

end
