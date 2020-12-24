class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(:live_on).order(:live_from_at).order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size
  validates :title, presence: true
  validates :live_on, presence: true
  validates :area, presence: true
  validates :act, presence: true
  
  scope :search, -> (search_params) do
    return if search_params.blank?
    
    act_like(search_params[:act])
      .live_on_from(search_params[:live_on_from])
      .live_on_to(search_params[:live_on_to])
      .area_like(search_params[:area])
  end
  
  scope :act_like, -> (act) { where('act LIKE ?', "%#{act}%") if act.present? }
  scope :live_on_from, -> (from) { where('? <= live_on', from) if from.present? }
  scope :live_on_to, -> (to) { where('live_on <= ?', to) if to.present? }
  scope :area_like, -> (area) { where('area LIKE ?', "%#{area}") if area.present? }
  
  private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "5MB未満である必要があります")
      end
    end
end
