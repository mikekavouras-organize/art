class CreateResumes < ActiveRecord::Migration[6.0]
  def change
    create_table :resumes do |t|
      t.timestamps
      t.boolean :active, default: true
    end
  end
end
