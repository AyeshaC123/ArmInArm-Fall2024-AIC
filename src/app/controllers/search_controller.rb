# Implements logic for searching for client profiles.
class SearchController < ApplicationController
  def index
    # The built-up parts of the WHERE clause.
    where = []
    # The values to match in the database.
    values = []
    # Add ID to filter if requested.
    if params[:id].present?
      where.push "id = ?"
      values.push params[:id]
    end
    # Add first name to filter if requested.
    if params[:first_name].present?
      where.push "first_name = ? collate nocase"
      values.push params[:first_name]
    end
    # Add last name to filter if requested.
    if params[:last_name].present?
      where.push "last_name = ? collate nocase"
      values.push params[:last_name]
    end
    if where.empty?
      # No search.
      @has_searched = false
      @clients = Client.none
    else
      # Do search.
      @has_searched = true
      @clients = Client.where([where.join(' and ')] + values)
    end
  end
end
