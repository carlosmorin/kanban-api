class CreateIssuesTags < ActiveRecord::Migration[6.0]
  def change
    create_table :issues_tags do |t|
      t.references :issue, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true
    end
  end
end
