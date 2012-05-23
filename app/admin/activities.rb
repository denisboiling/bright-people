# -*- coding: utf-8 -*-
ActiveAdmin.register Activity do
  menu label: 'Кружки'

  controller do
    autocomplete :activity, :title, full: true
  end

  filter :title, as: :autocomplete, :input_html => {'data-autocomplete' => '/admin/activities/autocomplete_activity_title', object: 'activity'}


  index do
    id_column
    column :title
    column :address
    column :users_rating
    column :experts_rating
    column :created_at
    column :updated_at
    column :additional_information
    column :parent_activities
    column :schedule
    default_actions
  end

  form partial: "form"

  show do
    attributes_table :id, :title, :address, :metro_station, :description,
                     :users_rating, :experts_rating, :created_at, :updated_at,
                     :additional_information, :parent_activities, :week

    panel 'Карта' do
      form do |f|
        input class: 'hidden_coords', value: activity.coords, type: 'hidden'
      end
      div id: 'edit_map' do
      end
    end
  end
end
