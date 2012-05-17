# -*- coding: utf-8 -*-
ActiveAdmin.register User do
  menu :label => "Пользователи"

  filter :email

  index do
    id_column
    column :email
    column :created_at
    default_actions
  end

  form do |f|
    f.inputs "Новый пользователь" do
      f.input :email
      f.buttons
    end
  end
end
