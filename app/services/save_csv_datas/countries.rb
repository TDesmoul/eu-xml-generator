class SaveCsvDatas::Countries < SaveCsvDatas::Elements
  def self.call
    super("countries")
  end

  def self.process_row(row)
    p row
    if product = Product.find_by(ref: row.delete("product_id"))
      p product
      p row
      country_codes = row.map{ |el| el[1] }.delete_if{ |el| el.nil? }
      p country_codes
      puts "Création des #{country_codes.count} countries pour #{product.ref}"
      country_codes.each do |country|
        product.countries.create!(code: country)
      end
    end
  end
end
