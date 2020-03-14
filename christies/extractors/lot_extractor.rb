module Christies
  class LotExtractor
    attr_accessor :data
    def initialize(agent, lot, errors_report=nil)
      @uri = lot['LotLink']
      @lot = lot
      @page = agent.get(@uri)
      @item_unavailable = @page.uri.to_s == "https://www.christies.com/?aspxerrorpath=/lotfinder/lot_details.aspx"
      @data = get_data
    end

    # different options
    # raise an error if the node is not found and end program
    # enter nil value if no node
    # raise error rescue enter nil and report error in file
    private

    def get_data
      LOGGER.info("fetching lot data at #{@uri}")
      lot = { lotDetails: @lot }
      if @item_unavailable
        lot.merge({ extra_details: nil })
      else
        lot.merge(extra_lot_details)
      end
    end

    def extra_lot_details
      { extra_details: {
          lotName: {
            primaryTitle: @page.search('#main_center_0_lblLotPrimaryTitle')&.text,
            secondaryTitle: @page.search('#main_center_0_lblLotSecondaryTitle')&.text
          },
          estimate: @page.search('#main_center_0_lblPriceEstimatedPrimary')&.text,
          lotDescription: @page.search('#main_center_0_lblLotDescription')&.text,
          lotProvenance: @page.search('#main_center_0_lblLotProvenance')&.text,
          lotLitterature: @page.search('#main_center_0_lblLiterature')&.text,
          lotExhibited: @page.search('#main_center_0_lblExhibited')&.text,
          lotNotes: @page.search('#main_center_0_lblLotNotes')&.text,
          lotSpecialNotice: @page.search('#main_center_0_lblSpecialNotice')&.text,
          preLotText: @page.search('#main_center_0_lblPreLotText')&.text,
          lotCondition: @page.search('#main_center_0_lblLotCondition')&.first.try('value'),
          lotCreatedOn: @page.search('#main_center_0_lblCreatedOn')&.first.try('value'),
          lotModifiedOn: @page.search('#main_center_0_lblModifiedOn')&.first.try('value')
        }
      }
    end
  end
end
