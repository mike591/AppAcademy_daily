class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: { in: ['PENDING', 'APPROVED', 'DENIED'] }
  validate :validate_overlapping

  belongs_to :cat, dependent: :destroy

  def overlapping_requests
    overlaps = CatRentalRequest
      .where.not(id: self.id)
      .where(cat_id: cat_id)
      .where(<<-SQL, start_date: start_date, end_date: end_date)
        NOT ( (start_date > :end_date) OR (end_date < :start_date) )
      SQL
  end

  def overlapping_approved_requests
    overlapping_requests.where("status = 'APPROVED'")
  end

  def overlapping_pending_requests
    overlapping_requests.where("status = 'PENDING'")
  end

  def validate_overlapping
    overlaps = overlapping_approved_requests

    if overlaps.size >= 1
      errors[:base] << "Cat is being used in that time frame."
    end
  end

  def approve!
    self.update_attribute(:status, 'APPROVED')

    overlaps = overlapping_pending_requests
    overlaps.each do |request|
      request.deny!
    end
  end

  def deny!
    self.update_attribute(:status, 'DENIED')
  end

end
