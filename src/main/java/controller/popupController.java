package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import logic.ShopService;

@Controller
@RequestMapping("popup")
public class popupController {
	@Autowired
	private ShopService service;
	
	@RequestMapping("*")
	public ModelAndView main() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
}
