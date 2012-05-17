# -*- coding: utf-8 -*-
ActiveAdmin.register Activity do
  menu :label => 'Кружки'

  filter :title

  index do
    id_column
    column :title
    column :address
    column :users_rating
    column :experts_rating
    column :created_at
    column :updated_at
    default_actions
  end

  form do |f|
    f.inputs 'Основное' do
      f.input :organization, as: :select, collection: Organization.all
      f.input :title
      f.input :address
      f.input :description, input_html: { size: 10 }
      f.input :users_rating
      f.input :experts_rating
    end
    f.inputs 'Карта' do
      f.input :coords, as: :hidden, input_html: { class: 'hidden_coords'}
      f.input :coords, input_html: { class: 'edit_map' }, label: false
    end
    f.buttons
  end

  show do
    attributes_table :id, :title, :address, :description, :users_rating, :experts_rating,
    :created_at, :updated_at

    panel 'Карта' do
      form do |f|
        input class: 'hidden_coords', value: activity.coords, type: 'hidden'
      end
      div id: 'edit_map' do
      end
    end
  end
end
