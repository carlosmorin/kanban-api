class AddCommentsCountToIssues < ActiveRecord::Migration[6.0]
  def change
    add_column :issues, :comments_count, :integer, default: 0
  end
end
