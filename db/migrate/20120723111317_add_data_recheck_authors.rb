class AddDataRecheckAuthors < ActiveRecord::Migration
  # Dirty and not optimize, but it work.
  # Assigned role author to users, who created articles
  def change
    Article.all.each do |article|
      next if article.author.role.name != 'user'
      puts "Add to user '#{article.author.name}' role 'author'"
      article.author.author!
    end
  end
end
