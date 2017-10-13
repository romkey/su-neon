class AdminController < ApplicationController
  def refresh_now
    NewsSource.all.each do |ns| ScanHeadlinesJob.perform_now(ns); end
    redirect_to '/'
  end

  def all_on
    Sign.all.each do |sign| sign.turn_on end
    redirect_to '/'
  end

  def all_off
    Sign.all.each do |sign| sign.turn_off end
    redirect_to '/'
  end
end
