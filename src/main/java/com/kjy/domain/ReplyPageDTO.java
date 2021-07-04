package com.kjy.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class ReplyPageDTO {
	// 댓글의 수와 List<ReplyVO> 두가지 정보를 같이 전달해줘야 함
	private int replyCnt;
	private List<ReplyVO> list;

}
