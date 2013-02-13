require "Qt4"

class NewGameDialog < Qt::Dialog
  def initialize(choices)
    super()
    @choices = choices.map { |choice| tr(choice) }
    # TODO Is this a hack? Need to guarantee that we're always checking the first value.
    @player_choices = [0, 0]
  end

  def setup_ui
    self.window_title = "New Game"
    resize(300, 150)

    button_box = Qt::DialogButtonBox.new(self)
    button_box.set_standard_buttons(Qt::DialogButtonBox::Cancel|Qt::DialogButtonBox::Ok)
    button_box.connect(SIGNAL(:accepted)) { accept unless @player_choices.include?(nil) }
    button_box.connect(SIGNAL(:rejected)) { reject }

    grid_layout = Qt::GridLayout.new(self)
    grid_layout.add_widget(button_box, 1, 0, 1, 2)

    @player_choices.each_index do |i|
      box = Qt::GroupBox.new("Player #{i+1}")
      grid_layout.add_widget(box, 0, i)
      vertical_layout = Qt::VBoxLayout.new(box)

      @choices.each_with_index do |choice, index|
        radio = Qt::RadioButton.new(choice)
        vertical_layout.add_widget(radio)

        radio.connect(SIGNAL(:clicked)) do
          @player_choices[i] = index
        end
      end
      box.find_child(Qt::RadioButton).checked = true
    end
  end
end
