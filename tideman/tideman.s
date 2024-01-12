	.file	"tideman.c"
	.text
	.globl	preferences
	.bss
	.align 32
	.type	preferences, @object
	.size	preferences, 324
preferences:
	.zero	324
	.globl	locked
	.align 32
	.type	locked, @object
	.size	locked, 81
locked:
	.zero	81
	.globl	candidates
	.align 32
	.type	candidates, @object
	.size	candidates, 72
candidates:
	.zero	72
	.globl	pairs
	.align 32
	.type	pairs, @object
	.size	pairs, 288
pairs:
	.zero	288
	.globl	pair_count
	.align 4
	.type	pair_count, @object
	.size	pair_count, 4
pair_count:
	.zero	4
	.globl	candidate_count
	.align 4
	.type	candidate_count, @object
	.size	candidate_count, 4
candidate_count:
	.zero	4
	.section	.rodata
	.align 8
.LC0:
	.string	"Usage: tideman [candidate ...]"
	.align 8
.LC1:
	.string	"Maximum number of candidates is %i\n"
.LC2:
	.string	"Number of voters: "
.LC3:
	.string	"Rank %i: "
.LC4:
	.string	"Invalid vote."
	.align 8
.LC5:
	.string	"(%d, %d) - %d pref_count, %d difference \n"
.LC6:
	.string	"[%d]"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$104, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movl	%edi, -132(%rbp)
	movq	%rsi, -144(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	cmpl	$1, -132(%rbp)
	jg	.L2
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	$1, %eax
	jmp	.L3
.L2:
	movl	-132(%rbp), %eax
	subl	$1, %eax
	movl	%eax, candidate_count(%rip)
	movl	candidate_count(%rip), %eax
	cmpl	$9, %eax
	jle	.L4
	movl	$9, %esi
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$2, %eax
	jmp	.L3
.L4:
	movl	$0, -124(%rbp)
	jmp	.L5
.L6:
	movl	-124(%rbp), %eax
	cltq
	addq	$1, %rax
	leaq	0(,%rax,8), %rdx
	movq	-144(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movl	-124(%rbp), %edx
	movslq	%edx, %rdx
	leaq	0(,%rdx,8), %rcx
	leaq	candidates(%rip), %rdx
	movq	%rax, (%rcx,%rdx)
	addl	$1, -124(%rbp)
.L5:
	movl	candidate_count(%rip), %eax
	cmpl	%eax, -124(%rbp)
	jl	.L6
	movl	$0, -120(%rbp)
	jmp	.L7
.L10:
	movl	$0, -116(%rbp)
	jmp	.L8
.L9:
	movl	-116(%rbp), %eax
	movslq	%eax, %rcx
	movl	-120(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$3, %rax
	addq	%rdx, %rax
	leaq	(%rax,%rcx), %rdx
	leaq	locked(%rip), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	addl	$1, -116(%rbp)
.L8:
	movl	candidate_count(%rip), %eax
	cmpl	%eax, -116(%rbp)
	jl	.L9
	addl	$1, -120(%rbp)
.L7:
	movl	candidate_count(%rip), %eax
	cmpl	%eax, -120(%rbp)
	jl	.L10
	movl	$0, pair_count(%rip)
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	get_int@PLT
	movl	%eax, -92(%rbp)
	movl	$0, -112(%rbp)
	jmp	.L11
.L18:
	movq	%rsp, %rax
	movq	%rax, %rbx
	movl	candidate_count(%rip), %eax
	movslq	%eax, %rdx
	subq	$1, %rdx
	movq	%rdx, -80(%rbp)
	movslq	%eax, %rdx
	movq	%rdx, %r12
	movl	$0, %r13d
	movslq	%eax, %rdx
	movq	%rdx, %r14
	movl	$0, %r15d
	cltq
	leaq	0(,%rax,4), %rdx
	movl	$16, %eax
	subq	$1, %rax
	addq	%rdx, %rax
	movl	$16, %esi
	movl	$0, %edx
	divq	%rsi
	imulq	$16, %rax, %rax
	movq	%rax, %rcx
	andq	$-4096, %rcx
	movq	%rsp, %rdx
	subq	%rcx, %rdx
.L12:
	cmpq	%rdx, %rsp
	je	.L13
	subq	$4096, %rsp
	orq	$0, 4088(%rsp)
	jmp	.L12
.L13:
	movq	%rax, %rdx
	andl	$4095, %edx
	subq	%rdx, %rsp
	movq	%rax, %rdx
	andl	$4095, %edx
	testq	%rdx, %rdx
	je	.L14
	andl	$4095, %eax
	subq	$8, %rax
	addq	%rsp, %rax
	orq	$0, (%rax)
.L14:
	movq	%rsp, %rax
	addq	$3, %rax
	shrq	$2, %rax
	salq	$2, %rax
	movq	%rax, -72(%rbp)
	movl	$0, -108(%rbp)
	jmp	.L15
.L17:
	movl	-108(%rbp), %eax
	addl	$1, %eax
	movl	%eax, %edx
	leaq	.LC3(%rip), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	movl	$0, %eax
	call	get_string@PLT
	movq	%rax, -64(%rbp)
	movq	-72(%rbp), %rdx
	movq	-64(%rbp), %rcx
	movl	-108(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	vote
	xorl	$1, %eax
	testb	%al, %al
	je	.L16
	leaq	.LC4(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	$3, %eax
	movq	%rbx, %rsp
	jmp	.L3
.L16:
	addl	$1, -108(%rbp)
.L15:
	movl	candidate_count(%rip), %eax
	cmpl	%eax, -108(%rbp)
	jl	.L17
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	record_preferences
	movl	$10, %edi
	call	putchar@PLT
	movq	%rbx, %rsp
	addl	$1, -112(%rbp)
.L11:
	movl	-112(%rbp), %eax
	cmpl	-92(%rbp), %eax
	jl	.L18
	call	add_pairs
	call	sort_pairs
	call	lock_pairs
	call	print_winner
	movl	$0, -104(%rbp)
	jmp	.L19
.L20:
	movl	-104(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	pairs(%rip), %rax
	movl	(%rdx,%rax), %eax
	movl	%eax, -88(%rbp)
	movl	-104(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	4+pairs(%rip), %rax
	movl	(%rdx,%rax), %eax
	movl	%eax, -84(%rbp)
	movl	-84(%rbp), %eax
	movslq	%eax, %rcx
	movl	-88(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$3, %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	leaq	0(,%rax,4), %rdx
	leaq	preferences(%rip), %rax
	movl	(%rdx,%rax), %ecx
	movl	-88(%rbp), %eax
	movslq	%eax, %rsi
	movl	-84(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$3, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	leaq	0(,%rax,4), %rdx
	leaq	preferences(%rip), %rax
	movl	(%rdx,%rax), %eax
	movl	%ecx, %edi
	subl	%eax, %edi
	movl	-84(%rbp), %eax
	movslq	%eax, %rcx
	movl	-88(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$3, %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	leaq	0(,%rax,4), %rdx
	leaq	preferences(%rip), %rax
	movl	(%rdx,%rax), %ecx
	movl	-104(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	4+pairs(%rip), %rax
	movl	(%rdx,%rax), %edx
	movl	-104(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rsi
	leaq	pairs(%rip), %rax
	movl	(%rsi,%rax), %eax
	movl	%edi, %r8d
	movl	%eax, %esi
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -104(%rbp)
.L19:
	movl	pair_count(%rip), %eax
	cmpl	%eax, -104(%rbp)
	jl	.L20
	movl	$0, -100(%rbp)
	jmp	.L21
.L24:
	movl	$0, -96(%rbp)
	jmp	.L22
.L23:
	movl	-96(%rbp), %eax
	movslq	%eax, %rcx
	movl	-100(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$3, %rax
	addq	%rdx, %rax
	leaq	(%rax,%rcx), %rdx
	leaq	locked(%rip), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	movl	%eax, %esi
	leaq	.LC6(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -96(%rbp)
.L22:
	movl	candidate_count(%rip), %eax
	cmpl	%eax, -96(%rbp)
	jl	.L23
	movl	$10, %edi
	call	putchar@PLT
	addl	$1, -100(%rbp)
.L21:
	movl	candidate_count(%rip), %eax
	cmpl	%eax, -100(%rbp)
	jl	.L24
	movl	$0, %eax
.L3:
	movq	-56(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L25
	call	__stack_chk_fail@PLT
.L25:
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.globl	vote
	.type	vote, @function
vote:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L27
.L30:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	candidates(%rip), %rax
	movq	(%rdx,%rax), %rdx
	movq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcasecmp@PLT
	testl	%eax, %eax
	jne	.L28
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-40(%rbp), %rax
	addq	%rax, %rdx
	movl	-4(%rbp), %eax
	movl	%eax, (%rdx)
	movl	$1, %eax
	jmp	.L29
.L28:
	addl	$1, -4(%rbp)
.L27:
	movl	candidate_count(%rip), %eax
	cmpl	%eax, -4(%rbp)
	jl	.L30
	movl	$0, %eax
.L29:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	vote, .-vote
	.globl	record_preferences
	.type	record_preferences, @function
record_preferences:
.LFB2:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L32
.L36:
	movl	$0, -4(%rbp)
	jmp	.L33
.L35:
	movl	candidate_count(%rip), %ecx
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %esi
	movl	-8(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	movq	-24(%rbp), %rdx
	movl	%eax, %edi
	call	is_ranked_higher
	testb	%al, %al
	je	.L34
	movl	-8(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %edx
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rcx
	movq	-24(%rbp), %rax
	addq	%rcx, %rax
	movl	(%rax), %ecx
	movslq	%ecx, %rdi
	movslq	%edx, %rsi
	movq	%rsi, %rax
	salq	$3, %rax
	addq	%rsi, %rax
	addq	%rdi, %rax
	leaq	0(,%rax,4), %rsi
	leaq	preferences(%rip), %rax
	movl	(%rsi,%rax), %eax
	leal	1(%rax), %esi
	movslq	%ecx, %rcx
	movslq	%edx, %rdx
	movq	%rdx, %rax
	salq	$3, %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	leaq	0(,%rax,4), %rdx
	leaq	preferences(%rip), %rax
	movl	%esi, (%rdx,%rax)
.L34:
	addl	$1, -4(%rbp)
.L33:
	movl	candidate_count(%rip), %eax
	cmpl	%eax, -4(%rbp)
	jl	.L35
	addl	$1, -8(%rbp)
.L32:
	movl	candidate_count(%rip), %eax
	cmpl	%eax, -8(%rbp)
	jl	.L36
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	record_preferences, .-record_preferences
	.globl	add_pairs
	.type	add_pairs, @function
add_pairs:
.LFB3:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	$0, -24(%rbp)
	jmp	.L39
.L43:
	movl	$0, -20(%rbp)
	jmp	.L40
.L42:
	movl	-20(%rbp), %eax
	movslq	%eax, %rcx
	movl	-24(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$3, %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	leaq	0(,%rax,4), %rdx
	leaq	preferences(%rip), %rax
	movl	(%rdx,%rax), %eax
	movl	%eax, -16(%rbp)
	movl	-24(%rbp), %eax
	movslq	%eax, %rcx
	movl	-20(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$3, %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	leaq	0(,%rax,4), %rdx
	leaq	preferences(%rip), %rax
	movl	(%rdx,%rax), %eax
	movl	%eax, -12(%rbp)
	movl	-12(%rbp), %edx
	movl	-16(%rbp), %eax
	movl	%edx, %esi
	movl	%eax, %edi
	call	is_preferred
	testb	%al, %al
	je	.L41
	movl	-24(%rbp), %eax
	movl	%eax, -8(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, -4(%rbp)
	movl	pair_count(%rip), %eax
	addl	$1, %eax
	movl	%eax, pair_count(%rip)
	movl	pair_count(%rip), %eax
	subl	$1, %eax
	cltq
	leaq	0(,%rax,8), %rcx
	leaq	pairs(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rax, (%rcx,%rdx)
.L41:
	addl	$1, -20(%rbp)
.L40:
	movl	candidate_count(%rip), %eax
	cmpl	%eax, -20(%rbp)
	jl	.L42
	addl	$1, -24(%rbp)
.L39:
	movl	candidate_count(%rip), %eax
	cmpl	%eax, -24(%rbp)
	jl	.L43
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	add_pairs, .-add_pairs
	.globl	sort_pairs
	.type	sort_pairs, @function
sort_pairs:
.LFB4:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$0, -56(%rbp)
	jmp	.L46
.L50:
	movl	-56(%rbp), %eax
	movl	%eax, -52(%rbp)
	jmp	.L47
.L49:
	movl	-52(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	pairs(%rip), %rax
	movl	(%rdx,%rax), %eax
	movl	%eax, -16(%rbp)
	movl	-52(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	4+pairs(%rip), %rax
	movl	(%rdx,%rax), %eax
	movl	%eax, -12(%rbp)
	movl	-56(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	pairs(%rip), %rax
	movl	(%rdx,%rax), %eax
	movl	-56(%rbp), %edx
	movslq	%edx, %rdx
	leaq	0(,%rdx,8), %rcx
	leaq	4+pairs(%rip), %rdx
	movl	(%rcx,%rdx), %edx
	movslq	%edx, %rcx
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$3, %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	leaq	0(,%rax,4), %rdx
	leaq	preferences(%rip), %rax
	movl	(%rdx,%rax), %ecx
	movl	-12(%rbp), %eax
	movslq	%eax, %rsi
	movl	-16(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$3, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	leaq	0(,%rax,4), %rdx
	leaq	preferences(%rip), %rax
	movl	(%rdx,%rax), %eax
	cmpl	%eax, %ecx
	jge	.L48
	movl	-56(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	pairs(%rip), %rax
	movq	(%rdx,%rax), %rax
	movq	%rax, -8(%rbp)
	movl	-56(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rcx
	leaq	pairs(%rip), %rdx
	movl	-52(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rsi
	leaq	pairs(%rip), %rax
	movq	(%rsi,%rax), %rax
	movq	%rax, (%rcx,%rdx)
	movl	-52(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rcx
	leaq	pairs(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rax, (%rcx,%rdx)
.L48:
	addl	$1, -52(%rbp)
.L47:
	movl	pair_count(%rip), %eax
	cmpl	%eax, -52(%rbp)
	jl	.L49
	addl	$1, -56(%rbp)
.L46:
	movl	pair_count(%rip), %eax
	cmpl	%eax, -56(%rbp)
	jl	.L50
	movl	$0, -48(%rbp)
	jmp	.L51
.L55:
	movl	-48(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	pairs(%rip), %rax
	movl	(%rdx,%rax), %eax
	movl	%eax, -40(%rbp)
	movl	-48(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	4+pairs(%rip), %rax
	movl	(%rdx,%rax), %eax
	movl	%eax, -36(%rbp)
	movl	-36(%rbp), %eax
	movslq	%eax, %rcx
	movl	-40(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$3, %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	leaq	0(,%rax,4), %rdx
	leaq	preferences(%rip), %rax
	movl	(%rdx,%rax), %ecx
	movl	-40(%rbp), %eax
	movslq	%eax, %rsi
	movl	-36(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$3, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	leaq	0(,%rax,4), %rdx
	leaq	preferences(%rip), %rax
	movl	(%rdx,%rax), %edx
	movl	%ecx, %eax
	subl	%edx, %eax
	movl	%eax, -32(%rbp)
	movl	-48(%rbp), %eax
	movl	%eax, -44(%rbp)
	jmp	.L52
.L54:
	movl	-44(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	pairs(%rip), %rax
	movl	(%rdx,%rax), %eax
	movl	%eax, -28(%rbp)
	movl	-44(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	4+pairs(%rip), %rax
	movl	(%rdx,%rax), %eax
	movl	%eax, -24(%rbp)
	movl	-24(%rbp), %eax
	movslq	%eax, %rcx
	movl	-28(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$3, %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	leaq	0(,%rax,4), %rdx
	leaq	preferences(%rip), %rax
	movl	(%rdx,%rax), %ecx
	movl	-28(%rbp), %eax
	movslq	%eax, %rsi
	movl	-24(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$3, %rax
	addq	%rdx, %rax
	addq	%rsi, %rax
	leaq	0(,%rax,4), %rdx
	leaq	preferences(%rip), %rax
	movl	(%rdx,%rax), %edx
	movl	%ecx, %eax
	subl	%edx, %eax
	movl	%eax, -20(%rbp)
	cmpl	$0, -20(%rbp)
	jle	.L53
	movl	-32(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jge	.L53
	movl	-48(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	pairs(%rip), %rax
	movq	(%rdx,%rax), %rax
	movq	%rax, -8(%rbp)
	movl	-48(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rcx
	leaq	pairs(%rip), %rdx
	movl	-44(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rsi
	leaq	pairs(%rip), %rax
	movq	(%rsi,%rax), %rax
	movq	%rax, (%rcx,%rdx)
	movl	-44(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rcx
	leaq	pairs(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rax, (%rcx,%rdx)
.L53:
	addl	$1, -44(%rbp)
.L52:
	movl	pair_count(%rip), %eax
	cmpl	%eax, -44(%rbp)
	jl	.L54
	addl	$1, -48(%rbp)
.L51:
	movl	pair_count(%rip), %eax
	cmpl	%eax, -48(%rbp)
	jl	.L55
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	sort_pairs, .-sort_pairs
	.globl	lock_pairs
	.type	lock_pairs, @function
lock_pairs:
.LFB5:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$0, -12(%rbp)
	jmp	.L58
.L59:
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	pairs(%rip), %rax
	movl	(%rdx,%rax), %eax
	movl	-12(%rbp), %edx
	movslq	%edx, %rdx
	leaq	0(,%rdx,8), %rcx
	leaq	4+pairs(%rip), %rdx
	movl	(%rcx,%rdx), %edx
	movslq	%edx, %rcx
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$3, %rax
	addq	%rdx, %rax
	leaq	(%rax,%rcx), %rdx
	leaq	locked(%rip), %rax
	addq	%rdx, %rax
	movb	$1, (%rax)
	addl	$1, -12(%rbp)
.L58:
	movl	pair_count(%rip), %eax
	cmpl	%eax, -12(%rbp)
	jl	.L59
	movl	$0, -8(%rbp)
	jmp	.L60
.L64:
	movl	$0, -4(%rbp)
	jmp	.L61
.L63:
	movl	-4(%rbp), %eax
	movslq	%eax, %rcx
	movl	-8(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$3, %rax
	addq	%rdx, %rax
	leaq	(%rax,%rcx), %rdx
	leaq	locked(%rip), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L62
	movl	-8(%rbp), %eax
	movslq	%eax, %rcx
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$3, %rax
	addq	%rdx, %rax
	leaq	(%rax,%rcx), %rdx
	leaq	locked(%rip), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L62
	movl	-4(%rbp), %eax
	movslq	%eax, %rcx
	movl	-8(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$3, %rax
	addq	%rdx, %rax
	leaq	(%rax,%rcx), %rdx
	leaq	locked(%rip), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	movl	-8(%rbp), %eax
	movslq	%eax, %rcx
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$3, %rax
	addq	%rdx, %rax
	leaq	(%rax,%rcx), %rdx
	leaq	locked(%rip), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
.L62:
	addl	$1, -4(%rbp)
.L61:
	movl	candidate_count(%rip), %eax
	cmpl	%eax, -4(%rbp)
	jl	.L63
	addl	$1, -8(%rbp)
.L60:
	movl	candidate_count(%rip), %eax
	cmpl	%eax, -8(%rbp)
	jl	.L64
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	lock_pairs, .-lock_pairs
	.section	.rodata
.LC7:
	.string	"%s \n"
	.text
	.globl	print_winner
	.type	print_winner, @function
print_winner:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	$0, -20(%rbp)
	jmp	.L67
.L71:
	movl	$0, -16(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L68
.L69:
	movl	-20(%rbp), %eax
	movslq	%eax, %rcx
	movl	-12(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	salq	$3, %rax
	addq	%rdx, %rax
	leaq	(%rax,%rcx), %rdx
	leaq	locked(%rip), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	addl	%eax, -16(%rbp)
	addl	$1, -12(%rbp)
.L68:
	movl	candidate_count(%rip), %eax
	cmpl	%eax, -12(%rbp)
	jl	.L69
	cmpl	$0, -16(%rbp)
	jne	.L70
	movl	-20(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	leaq	candidates(%rip), %rax
	movq	(%rdx,%rax), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC7(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
.L70:
	addl	$1, -20(%rbp)
.L67:
	movl	candidate_count(%rip), %eax
	cmpl	%eax, -20(%rbp)
	jl	.L71
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	print_winner, .-print_winner
	.globl	is_ranked_higher
	.type	is_ranked_higher, @function
is_ranked_higher:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)
	movl	%esi, -24(%rbp)
	movq	%rdx, -32(%rbp)
	movl	%ecx, -36(%rbp)
	movl	$-1, -12(%rbp)
	movl	$-1, -8(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L74
.L77:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	cmpl	%eax, -20(%rbp)
	jne	.L75
	movl	-4(%rbp), %eax
	movl	%eax, -12(%rbp)
.L75:
	movl	-4(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %eax
	cmpl	%eax, -24(%rbp)
	jne	.L76
	movl	-4(%rbp), %eax
	movl	%eax, -8(%rbp)
.L76:
	addl	$1, -4(%rbp)
.L74:
	movl	-4(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jl	.L77
	movl	-12(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	.L78
	movl	$1, %eax
	jmp	.L79
.L78:
	movl	$0, %eax
.L79:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	is_ranked_higher, .-is_ranked_higher
	.globl	is_preferred
	.type	is_preferred, @function
is_preferred:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-4(%rbp), %eax
	cmpl	-8(%rbp), %eax
	setg	%al
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	is_preferred, .-is_preferred
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
