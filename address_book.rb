require 'rubygems'
require 'yaml'

class Person
  # Attributes for the Person class and all its subclasses
  attr_accessor :first_name
  attr_accessor :last_name
  # TODO 1. Add more!
end

class Trainee < Person
  attr_accessor :preferred_text_editor
end

class Instructor < Person
  attr_accessor :teaching_experience
end

Shoes.app title: "Ruby Address Book", width: 520 do
  # We're using an Array as our data store
  @address_book = []
  # Instantiate a Trainee by default
  @person = Trainee.new

  # The row of buttons to lookup Person objects in the address_book
  ('A'..'Z').each do |letter|
    flow width: 40 do
      button letter do
        @form.clear
        @form.append do
          # TODO 5. Add each of the Person objects in the address_book where the
          # last name matches
        end
      end
    end
  end

  stack margin: 20 do
    flow do
      caption "Type"
      list_box :items => %w(Trainee Instructor) do |selected|
        debug selected.text

        # TODO 3 Create a Trainee or an Instructor using a Person factory method
        # and store the result in @person

        # Show the fields for the user to fill in
        draw_input_form(selected.text)
      end
    end

    @form = stack do
      # This reserves space for the form elements to be appended later by the
      # draw_input_form method
    end

    # A method to draw the the input fields, default is Trainee
    def draw_input_form(type = "Trainee")
      @form.clear
      @form.append do
        flow do
          caption "First name"
          @first_name = edit_line
        end

        flow do
          caption "Last name"
          @last_name = edit_line
        end

        # TODO 4. Add fields for the user to fill in, but only if they are
        # relevant to the given user type.

        button "Save" do
          # Set the persons's name to the contents of the text box
          @person.first_name = @first_name.text.strip.chomp
          @person.last_name = @last_name.text.strip.chomp

          # TODO: 2. Finish the implementation to set the other fields. Can
          # we refactor this into the Class?

          # Append this to our address_book Array
          @address_book << @person

          # TODO: 6. Open a address_book.yml YAML file and write it out
          debug @person.to_yaml

          alert 'Saved'
        end
      end
    end

    # Actually draw the form
    draw_input_form
  end

end