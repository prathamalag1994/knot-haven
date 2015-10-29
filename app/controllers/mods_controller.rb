class ModsController < ApplicationController
  def new
  end
 
  def create
    general = current_user #anyone can upload
  	@mod = Mod.new(mod_params)
  	if @mod.save
      if @mod.latest
        if Mod.where(:uid => general.id).where(:latest => true).count > 1
          @change = Mod.where(:uid => general.id).where(:latest => true).first
          @change.latest = false
          @change.save
        end
        @mod.latest = true
      end
    end
    @mod.save
  	redirect_to '/view'
  end
  
  private
  def mod_params
    params.require(:mod).permit(:title, :latest, :urn, :uid)
  end
end
