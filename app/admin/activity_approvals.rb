# -*- coding: utf-8 -*-
ActiveAdmin.register ActivityApproval do
  menu label: 'Одобрение кружков'

  filter :activity, input_html: { class: 'chosen_autocomplete' }
  filter :user, input_html: { class: 'chosen_autocomplete' }

  index do
    id_column
    column :activity
    column :user
    column :created_at
    column :updated_at
    default_actions
  end

  form do |f|
    f.inputs 'Основное' do
      f.input :user, include_blank: false, input_html: { class: 'chosen_autocomplete' }
      f.input :activity, include_blank: false, input_html: { class: 'chosen_autocomplete' }
      f.input :text
    end
    f.buttons
  end

  show do
    attributes_table :id, :user, :activity, :created_at, :updated_at

    panel 'Текст' do
      resource.text
    end
  end
end
