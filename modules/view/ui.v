module view

import gg
import gx
import sobj
import vector2

pub struct Ui {
mut:
	gg      &gg.Context
	image   gg.Image
	vehicle sobj.Vehicle
	target  vector2.Vec2
}

pub fn new_ui() &Ui {
	mut ui := &Ui{
		gg: 0
	}
	ui.gg = gg.new_context(
		bg_color: gx.black
		width: 800
		height: 600
		create_window: true
		window_title: 'Vehcicle'
		frame_fn: frame
		event_fn: on_event
		init_fn: init_image
		user_data: ui
	)
	ui.vehicle = sobj.new_vehicle(400, 300)
	ui.target = vector2.Vec2{400, 300}
	return ui
}

pub fn (ui Ui) run() {
	ui.gg.run()
}

fn init_image(mut ui Ui) {
	ui.image = ui.gg.create_image('car.png')
}

fn frame(mut ui Ui) {
	ui.vehicle.wander()
	ui.vehicle.update()
	ui.vehicle.border(800,600)
	ui.gg.begin()
	ui.draw()
	ui.gg.end()
}

fn (mut ui Ui) draw() {
	img_cfg := gg.DrawImageConfig{
		img: &ui.image
		img_rect: gg.Rect{ui.vehicle.location.x - (ui.image.width / 2), ui.vehicle.location.y - (ui.image.height / 2), ui.image.width, ui.image.height}
		part_rect: gg.Rect{0, 0, ui.image.width, ui.image.height}
		rotate: int(ui.vehicle.direction)
	}
	ui.gg.draw_image_with_config(img_cfg)
}

fn on_event(e &gg.Event, mut ui Ui) {
	match e.typ {
		.mouse_move {
			ui.target = vector2.Vec2{e.mouse_x, e.mouse_y}
		}
		else {}
	}
}
