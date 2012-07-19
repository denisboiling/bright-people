# -*- coding: utf-8 -*-
ActiveAdmin.register User do
  menu label: 'Пользователи'

  scope :all, :default => true
  scope :experts
  scope :usuals
  scope :managers

  filter :name
  filter :email

  index do
    id_column
    column "Фотография" do |user|
      link_to image_tag(user.avatar, alt: user.name), admin_user_path(user)
    end
    column "Имя" do |user|
      user_vk_link(user)
    end
    column :created_at
    default_actions
  end

  form partial: "form"

  show do
    attributes_table :name, :description, :about, :created_at, :updated_at

    panel 'Фотография' do
      image_tag(user.avatar.url)
    end
  end
end
