# -*- coding: utf-8 -*-
ActiveAdmin.register Organization do

  controller do
    autocomplete :organization, :title, full: true
  end

  filter :title, as: :autocomplete, input_html: {'data-autocomplete' => '/admin/organizations/autocomplete_organization_title', object: 'organization'}

  index do
    id_column
    column :title
    column :address
    column :created_at
    default_actions
  end

  form do |f|
    f.inputs 'Основное' do
      f.input :title
      f.input :address
      f.input :metro_station, as: :select, collection: MetroStation.all
    end
    f.inputs 'Карта' do
      f.input :coords, as: :hidden, input_html: { class: 'hidden_coords'}
      f.input :coords, input_html: { class: 'edit_map' }, label: false
    end
    f.buttons
  end

  show do
    attributes_table :title, :address, :created_at, :updated_at, :metro_station

    panel 'Карта' do
      form do |f|
        input class: 'hidden_coords', value: organization.coords, type: 'hidden'
      end
      div id: 'edit_map' do
      end
    end
  end

end
