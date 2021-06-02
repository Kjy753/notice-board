package com.kjy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kjy.domain.BoardVO;
import com.kjy.domain.Criteria;
import com.kjy.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {

	private BoardService service;
	
//	@GetMapping("/list")
//	public void list(Model model) {
//		log.info("list");
//		
//		model.addAttribute("list",service.getList());
//	}
	
	@GetMapping("/list")
	public void list(Criteria cri ,Model model) {
		log.info("list");
		log.info(cri+"페이지 번호 ");
		log.info("--------------------------");
		model.addAttribute("list",service.getList(cri));
	}
	
	@GetMapping("/register")
	public void registerGET() {
		
	}
	
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		
		log.info("register: "+ board);
		
		service.register(board);
		
		rttr.addFlashAttribute("result", board.getBno());
		
		return "redirect:/board/list";
	}
	
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("bno") Long bno, Model model) {
		/* 게시글 조회 */
		log.info("/get");
		
		model.addAttribute("board", service.get(bno));
	}
	
	@PostMapping("/modify")
	public String modigy(BoardVO board, RedirectAttributes rttr) {
		
		log.info("modify: "+ board);
		 
		if(service.modify(board)) {
			rttr.addFlashAttribute("reslut","success");
		}
		
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	public String removd(@RequestParam("bno") Long bno, RedirectAttributes rttr) {
		
		log.info("remove :" + bno);
		
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/board/list";
	}
	
}
