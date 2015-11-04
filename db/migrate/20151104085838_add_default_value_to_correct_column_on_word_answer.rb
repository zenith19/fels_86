class AddDefaultValueToCorrectColumnOnWordAnswer < ActiveRecord::Migration
  def change
    change_column :word_answers, :correct, :boolean, default: false
  end
end
