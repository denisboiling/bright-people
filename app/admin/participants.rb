# -*- coding: utf-8 -*-
ActiveAdmin.register Participant do
  menu label: 'Участники фестиваля', :parent => "Фестиваль"

  scope :all, :default => true
  scope :headliners
  scope :not_headliners

  scope :music_stage do |participants|
    participants.where(:category => 'music_stage')
  end
  scope :doll_stage do |participants|
    participants.where(:category => 'doll_stage')
  end
  scope :circus_stage do |participants|
    participants.where(:category => 'circus_stage')
  end
  scope :street_theater do |participants|
    participants.where(:category => 'street_theater')
  end
  scope :master_class do |participants|
    participants.where(:category => 'master_class')
  end

  filter :title

  index do
    id_column
    column "Фотография" do |p|
        link_to image_tag(p.logo.url(:thumb), alt: p.title), admin_participant_path(p)
    end
    column :title
    column :headliner
    column :category
    column :priority
    column :description
    default_actions
  end

  form partial: 'form'

  show do
    attributes_table :title, :headliner, :priority, :category, :updated_at

    panel 'Лого' do
      image_tag resource.logo.url(:medium)
    end

    panel 'Текст' do
      raw resource.description
    end
  end
end
