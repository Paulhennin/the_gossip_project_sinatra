require 'csv'
require 'json'

class Gossip
attr_accessor :author, :content, :id

#initialise la class gossip, mets en place les paramètres.
    def initialize(author, content)
      @author = author
      @content = content
      @tab = []
      @hash= Hash.new
      @hash[@author] = @content
    end

    def save

      #fait un save en Json
      File.open("db/gossip.json","a") do |f|
        f.write(JSON.pretty_generate([@author , @content]))
        puts "terminé JSON"
      end

      #fait un save en csv
        CSV.open("db/gossip.csv","a") do |csv|
           csv << [@author , @content]
           puts "Terminé CSV"
           end

    end
#permet la relecture du fichier CSV
    def self.all
      all_gossips = []
      CSV.read("./db/gossip.csv").each do |csv_line|
        all_gossips << Gossip.new(csv_line[0], csv_line[1])
      end
      return all_gossips
    end
#permet de trouver le commentaire souhaité dans une recherche via le fichier CSV
    def self.find(id)
      @id = id
      all_gossips = self.all
      return all_gossips[@id.to_i]
    end

#essais d'edit des commentaires
    def self.edit(id, edit)
      @edit = edit
      @content = edit
      @id = id
      all_gossips = self.all
      all_gossips[@id][0]= @author
      all_gossips[@id][1]= @content
      return all_gossips
    end
end
