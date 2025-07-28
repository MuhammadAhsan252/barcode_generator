class Barcode < ApplicationRecord
  has_one_attached :image

  before_save :generate_barcode_image, if: -> { value_changed? && value.present? }

  validates :value, presence: true

  private

  def generate_barcode_image
    return if value.blank?

    code = Barby::Code128B.new(value)
    png = code.to_png(xdim: 2, height: 100)

    image.attach(
      io: StringIO.new(png),
      filename: "#{value.parameterize}.png",
      content_type: "image/png"
    )
  rescue StandardError => e
    errors.add(:base, "Failed to generate barcode image: #{e.message}")
  end
end
