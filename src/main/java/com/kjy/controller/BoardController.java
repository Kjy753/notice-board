package com.kjy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kjy.domain.BoardVO;
import com.kjy.domain.Criteria;
import com.kjy.domain.PageDTO;
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
		model.addAttribute("pageMaker",new PageDTO(cri,service.getTotal(cri)));
	}
	
	@GetMapping("/register")
	public void registerGET() {
		
	}
	
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		
		log.info("=============================");
		
		log.info("register: "+ board);
		if(board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		log.info("=======================");
		
		service.register(board);
		
		rttr.addFlashAttribute("result", board.getBno());
		
		
		return "redirect:/board/list";
	}
	
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri")Criteria cri, Model model) {
		/* 게시글 조회 */
		log.info("/get");
		
		model.addAttribute("board", service.get(bno));
	}
	
	@PostMapping("/modify")
	public String modigy(BoardVO board, Criteria cri, RedirectAttributes rttr) {
		
		log.info("modify: "+ board);
		 
		if(service.modify(board)) {
			rttr.addFlashAttribute("reslut","success");
		}
		
		/*
		 * rttr.addAttribute("pageNum", cri.getPageNum());
		 * rttr.addAttribute("amount",cri.getAmount()); 
		 * rttr.addAttribute("type", cri.getType());
		 * rttr.addAttribute("keyword", cri.getKeyword());
		 */
		// 파라미터를 하나의 링크로 연결 -> cri.getListLink()
		return "redirect:/board/list" + cri.getListLink();
	}
	
	@PostMapping("/remove")
	public String removd(@RequestParam("bno") Long bno, Criteria cri, RedirectAttributes rttr) {
		
		log.info("remove :" + bno);
		
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result","success");
		}
		
		/*
		 * rttr.addAttribute("pageNum", cri.getPageNum()); 
		 * rttr.addAttribute("amount",cri.getAmount());
		 * rttr.addAttribute("type", cri.getType());
		 * rttr.addAttribute("keyword", cri.getKeyword());
		 */
		
		return "redirect:/board/list" + cri.getListLink();
	}
	
}
