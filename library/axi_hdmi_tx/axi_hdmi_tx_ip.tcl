# ip

source ../scripts/adi_env.tcl
source $ad_hdl_dir/library/scripts/adi_ip.tcl

adi_ip_create axi_hdmi_tx
adi_ip_files axi_hdmi_tx [list \
  "$ad_hdl_dir/library/common/ad_mem.v" \
  "$ad_hdl_dir/library/common/ad_rst.v" \
  "$ad_hdl_dir/library/common/ad_csc_1_mul.v" \
  "$ad_hdl_dir/library/common/ad_csc_1_add.v" \
  "$ad_hdl_dir/library/common/ad_csc_1.v" \
  "$ad_hdl_dir/library/common/ad_csc_RGB2CrYCb.v" \
  "$ad_hdl_dir/library/common/ad_ss_444to422.v" \
  "$ad_hdl_dir/library/common/up_axi.v" \
  "$ad_hdl_dir/library/common/up_xfer_cntrl.v" \
  "$ad_hdl_dir/library/common/up_xfer_status.v" \
  "$ad_hdl_dir/library/common/up_clock_mon.v" \
  "$ad_hdl_dir/library/common/up_hdmi_tx.v" \
  "$ad_hdl_dir/library/xilinx/common/ad_mul.v" \
  "$ad_hdl_dir/library/xilinx/common/up_xfer_cntrl_constr.xdc" \
  "$ad_hdl_dir/library/xilinx/common/ad_rst_constr.xdc" \
  "$ad_hdl_dir/library/xilinx/common/up_xfer_status_constr.xdc" \
  "$ad_hdl_dir/library/xilinx/common/up_clock_mon_constr.xdc" \
  "axi_hdmi_tx_constr.xdc" \
  "axi_hdmi_tx_vdma.v" \
  "axi_hdmi_tx_es.v" \
  "axi_hdmi_tx_core.v" \
  "axi_hdmi_tx.v" ]

adi_ip_properties axi_hdmi_tx

set_property driver_value 0 [ipx::get_ports *hsync* -of_objects [ipx::current_core]]
set_property driver_value 0 [ipx::get_ports *vsync* -of_objects [ipx::current_core]]
set_property driver_value 0 [ipx::get_ports *data* -of_objects [ipx::current_core]]
set_property driver_value 0 [ipx::get_ports *es_data* -of_objects [ipx::current_core]]

set_property driver_value 0 [ipx::get_ports *vdma_fs* -of_objects [ipx::current_core]]
set_property driver_value 0 [ipx::get_ports *vdma_valid* -of_objects [ipx::current_core]]
set_property driver_value 0 [ipx::get_ports *vdma_data* -of_objects [ipx::current_core]]
set_property driver_value 0 [ipx::get_ports *vdma_ready* -of_objects [ipx::current_core]]

set_property value_format string [ipx::get_user_parameters INTERFACE -of_objects [ipx::current_core]]
set_property value_format string [ipx::get_hdl_parameters INTERFACE -of_objects [ipx::current_core]]
set_property value_validation_list {16_BIT 24_BIT 36_BIT 16_BIT_EMBEDDED_SYNC} \
  [ipx::get_user_parameters INTERFACE -of_objects [ipx::current_core]]

set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.INTERFACE')) == "16_BIT"} \
  [ipx::get_ports *hdmi_16* -of_objects [ipx::current_core]]
set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.INTERFACE')) == "24_BIT"} \
  [ipx::get_ports *hdmi_24* -of_objects [ipx::current_core]]
set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.INTERFACE')) == "36_BIT"} \
  [ipx::get_ports *hdmi_36* -of_objects [ipx::current_core]]
set_property enablement_dependency {spirit:decode(id('MODELPARAM_VALUE.INTERFACE')) == "16_BIT_EMBEDDED_SYNC"} \
  [ipx::get_ports *hdmi_16_es_data* -of_objects [ipx::current_core]]

ipx::infer_bus_interface hdmi_clk xilinx.com:signal:clock_rtl:1.0 [ipx::current_core]
ipx::infer_bus_interface hdmi_out_clk xilinx.com:signal:clock_rtl:1.0 [ipx::current_core]
ipx::infer_bus_interface vdma_clk xilinx.com:signal:clock_rtl:1.0 [ipx::current_core]

ipx::save_core [ipx::current_core]

