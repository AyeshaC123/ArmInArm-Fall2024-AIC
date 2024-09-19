class ReviewsController < ApplicationController
  require 'will_paginate/array'

  # default viewer for households needing review
  def index
    @unreviewed_households = Household.where(reviewed: [nil, false])
      .select(:id, :headname, :headdob, :created_at)
      .order(created_at: :asc)
      .paginate(page: params[:page], per_page: 10)
  end

  # approval button - mark the reviewed flag as true
  def approve
    @household = Household.find(params[:id])
    if @household.update(reviewed: true)
      redirect_to reviews_path, notice: 'Household approved successfully.'
    else
      redirect_to reviews_path, alert: 'Failed to approve household.'
    end
  end

  # denial button - destroy it from the database
  def deny
    @household = Household.find(params[:id])
    if @household.destroy
      redirect_to reviews_path, notice: 'Household deleted successfully.'
    else
      redirect_to reviews_path, alert: 'Failed to delete household.'
    end
  end

  # show button - go to the next page to display the whole set of info
  def show
    @household = Household.find(params[:id])
  end

  # bulk approval
  def approve_multiple
    @households = Household.where(id: params[:selected_review_ids])
    if @households.update_all(reviewed: true)
      redirect_to reviews_path, notice: 'Selected households approved successfully.'
    else
      redirect_to reviews_path, alert: 'Failed to approve selected households.'
    end
  end

  # bulk denial
  def deny_multiple
    @households = Household.where(id: params[:selected_review_ids])
    if @households.destroy_all
      redirect_to reviews_path, notice: 'Selected households deleted successfully.'
    else
      redirect_to reviews_path, alert: 'Failed to delete selected households.'
    end
  end
end
#team 11 added this