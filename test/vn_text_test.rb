require_relative "test_helper"

class VnTextTest < Minitest::Test
  def test_vntext_basic
    store_names ["thành phố Hồ Chí Minh"], VnText
    texts = VnText.search("*", execute: false)
    assert_equal ["thành phố Hồ Chí Minh"], texts.map(&:name)
  end

  def test_order_string
    store_names ["Quận 1", "Quận 2", "Quận 3", "Quận 4"], VnText
    assert_search "quan", ["Quận 1", "Quận 2", "Quận 3", "Quận 4"], { order: "name" }, VnText
  end

  def test_order_string_1
    store_names ["Quận 1", "Căn hộ Quận 1", "Chung cư Quận 1", "Quận 4"], VnText
    assert_search "Quan 1", ["Quận 1", "Căn hộ Quận 1", "Chung cư Quận 1", "Quận 4"], { match: [:vietnamese, :word_start] }, VnText
    assert_search "Can ho Quan 1", ["Căn hộ Quận 1"], { match: [:vietnamese, :word_start] }, VnText
  end

  def test_order_string_2
    # store_names ["Tân Bình", "Bình Tân", "Tân Phú"], VnText
    # texts = VnText.search("*", execute: false)
    # assert_equal ["thành phố Hồ Chí Minh"], texts.map(&:name)
    # assert_search "Tan Binh", ["Tân Bình"], { match: [:vietnamese, :phase] }, VnText
    # assert_search "Tan Binh", ["Tân Bình"], { match: [:word_start], debug: true}, VnText
    # assert_search "TanBinh", ["Tân Bình"], { match: [:word_start] }, VnText
    # assert_search "Binh Tan", ["Bình Tân"], { match: [:word_start] }, VnText
    # assert_search "BinhTan", ["Bình Tân"], { match: [:word_start] }, VnText
    store_names ["Tân Bình", "Bình Tân"], VnText
    # texts = VnText.search("*", execute: false)
    # assert_equal ["thành phố Hồ Chí Minh"], texts.map(&:name)
    assert_order "Tân Bình", ["Tân Bình", "Bình Tân"], { match: [:vietnamese, :word_start] }, VnText
    assert_order "binhtan", ["Bình Tân"], { match: [:vietnamese, :suggest] }, VnText
  end

  # def test_order_string_3
  #   store_names ["Mua chung cư Thủ Dầu Một, Bình Dương", "Bán"], VnText
  #   texts = VnText.search("*", execute: false)
  #   assert_equal ["thành phố Hồ Chí Minh"], texts.map(&:name)
  # end
end