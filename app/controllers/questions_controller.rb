# frozen_string_literal: true

class QuestionsController < ApplicationController
  def index
    @texts = {
      prompt: flash[:prompt],
      result: flash[:result]
    }
  end

  def create
    @prompt = params[:prompt]
    if @prompt
      result = run(prompt: "#{@prompt}\nPlease answer in Japanese.").gsub(/\RNext Actions:[\S\s]+$/, '')
      redirect_to questions_path, flash: { prompt: @prompt, result: }
    else
      render :index
    end
  end

  private

  def run(prompt:)
    boxcars = [Boxcars::Calculator.new, Boxcars::GoogleSearch.new]
    Boxcars.train.new(boxcars:).run(prompt)
  end
end
