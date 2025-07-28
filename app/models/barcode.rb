class Barcode < ApplicationRecord
    has_one_attached :image

    before_validation :generate_barcode_image
    validates :value, presence: true, uniqueness: true
    
    private
    def generate_barcode_image
        return if value.blank?

        code = Barby::Code128B.new(value)
        png = code.to_png(xdim: 2, height: 100)
        self.image.attach(io: StringIO.new(png), filename: "#{value}.png", content_type: 'image/png')
    rescue StandardError => e
        errors.add(:base, "Failed to generate barcode image: #{e.message}")
    end

end
