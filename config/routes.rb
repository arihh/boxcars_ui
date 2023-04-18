# frozen_string_literal: true

Rails.application.routes.draw do
  root 'questions#index'

  resources :questions, only: %i[index create]
end
