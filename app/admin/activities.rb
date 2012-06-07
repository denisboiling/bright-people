# -*- coding: utf-8 -*-
ActiveAdmin.register Activity do

  controller do
    autocomplete :activity, :title, full: true

    def create
      create! do |format|
        redirect_to '/admin/users' and return
      end
    end
  end

  # member_action :create, :method => :post do
  #   # create! do |format|
  #   #   format.html { redirect_to '/'}
  #   # end
  #   create! { '/' }
  # end


  filter :title, as: :autocomplete, input_html: {'data-autocomplete' => '/admin/activities/autocomplete_activity_title', object: 'activity'}

  index do
    id_column
    column :title
    column :address
    column :users_rating
    default_actions
  end

  form partial: "form"

  show do
    attributes_table :id, :title, :address, :metro_station, :description,
    :users_rating, :created_at, :updated_at,
    :additional_information, :parent_activities

    panel 'Карта' do
      form do |f|
        input class: 'hidden_coords', value: activity.coords, type: 'hidden'
      end
      div id: 'edit_map' do
      end
    end
  end
end
