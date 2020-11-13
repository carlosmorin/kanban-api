class CreateIssues < ActiveRecord::Migration[6.0]
  def change
    create_table :issues do |t|
      t.string :subject
      t.text :description
      t.integer :status
      t.datetime :due_date
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
