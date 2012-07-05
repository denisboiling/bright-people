# -*- coding: utf-8 -*-
ActiveAdmin.register ContestMembership do
  menu label: "Участники конкурсов", :parent => "Конкурсы"

  filter :contest, input_html: { class: 'chosen_autocomplete' }
  filter :user, input_html: { class: 'chosen_autocomplete' }
  
  index do
    id_column
    column :name
    column :contest
    column :user
    default_actions
  end

  form html: { enctype: 'multipart/form-data' } do |f|
    f.inputs 'Основное' do
      f.input :name
      f.input :user, include_blank: false, input_html: { class: 'chosen_autocomplete' }
      f.input :contest, include_blank: false, input_html: { class: 'chosen_autocomplete' }
      f.input :description, input_html: {size: 10}
      f.input :picture, as: :file, hint: f.template.image_tag(f.object.picture.url(:medium))
    end
    f.buttons
  end

  show do
    attributes_table :id, :name, :description

    panel 'Фотография' do
      image_tag(contest_membership.picture.url)
    end
  end
end
