alias OF="OVERWRITE_FIXTURES=1"
alias dbnuke='bundle exec rake db:schema:load && bundle exec rake db:seed:replant && bundle exec rake db:migrate; RAILS_ENV=test bundle exec rake db:schema:load && RAILS_ENV=test bundle exec rake db:seed:replant && RAILS_ENV=test bundle exec rake db:migrate'
