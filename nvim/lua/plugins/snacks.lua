return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	dependencies = {
		"amansingh-afk/milli.nvim",
	},
	keys = {
		{
			"<leader>lf",
			"<cmd>Snacks.lazygit.log_file()<CR>",
			desc = "Lazygit Log File",
		},
		{
			"<leader>ll",
			"<cmd>lua Snacks.lazygit.log()<CR>",
			desc = "Lazygit Log",
		},
		{
			"<leader>lg",
			"<cmd>lua Snacks.lazygit()<CR>",
			desc = "Lazygit",
		},
		{
			"<leader>ff",
			"<cmd>lua Snacks.picker.smart()<CR>",
			desc = "Smart Find Files",
		},
		{
			"<leader>fs",
			"<cmd>lua Snacks.picker.grep()<CR>",
			desc = "Grep",
		},
		{
			"<leader>:",
			"<cmd>lua Snacks.picker.command_history()<CR>",
			desc = "Command History",
		},
		-- find
		{
			"<leader>fb",
			"<cmd>lua Snacks.picker.buffers()<CR>",
			desc = "Buffers",
		},
		{
			"<leader>fg",
			"<cmd>lua Snacks.picker.git_files()<CR>",
			desc = "Find Git Files",
		},
		{
			"<leader>fp",
			"<cmd>lua Snacks.picker.projects()<CR>",
			desc = "Projects",
		},
		{
			"<leader>fo",
			"<cmd>lua Snacks.picker.recent()<CR>",
			desc = "Recent",
		},
		{
			"<leader>gb",
			"<cmd>lua Snacks.picker.grep_buffers()<CR>",
			desc = "Grep Open Buffers",
		},
		{
			"<leader>fc",
			"<cmd>lua Snacks.picker.grep_word()<CR>",
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},
		-- search
		{
			"<leader>sC",
			"<cmd>lua Snacks.picker.commands()<CR>",
			desc = "Commands",
		},
		{
			"<leader>sD",
			"<cmd>lua Snacks.picker.diagnostics()<CR>",
			desc = "Diagnostics",
		},
		{
			"<leader>sd",
			"<cmd>lua Snacks.picker.diagnostics_buffer()<CR>",
			desc = "Buffer Diagnostics",
		},
		{
			"<leader>sh",
			"<cmd>lua Snacks.picker.help()<CR>",
			desc = "Help Pages",
		},
		{
			"<leader>sH",
			"<cmd>lua Snacks.picker.highlights()<CR>",
			desc = "Highlights",
		},
		{
			"<leader>si",
			"<cmd>lua Snacks.picker.icons()<CR>",
			desc = "Icons",
		},
		{
			"<leader>sj",
			"<cmd>lua Snacks.picker.jumps()<CR>",
			desc = "Jumps",
		},
		{
			"<leader>sk",
			"<cmd>lua Snacks.picker.keymaps()<CR>",
			desc = "Keymaps",
		},
		{
			"<leader>sl",
			"<cmd>lua Snacks.picker.loclist()<CR>",
			desc = "Location List",
		},
		{
			"<leader>sm",
			"<cmd>lua Snacks.picker.marks()<CR>",
			desc = "Marks",
		},
		{
			"<leader>sM",
			"<cmd>lua Snacks.picker.man()<CR>",
			desc = "Man Pages",
		},
		{
			"<leader>sp",
			"<cmd>lua Snacks.picker.lazy()<CR>",
			desc = "Search for Plugin Spec",
		},
		{
			"<leader>fx",
			"<cmd>lua Snacks.picker.qflist()<CR>",
			desc = "Quickfix List",
		},
		{
			"<leader>sr",
			"<cmd>lua Snacks.picker.resume()<CR>",
			desc = "Resume",
		},
		{
			"<leader>u",
			[[<cmd> lua Snacks.picker.undo({win={input={keys={["<c-y>"] = { "yank_add", mode = { "n", "i" } },["<s-y>"] = { "yank_del", mode = { "n", "i" } },}}}}) <CR>]],
			desc = "Undo History",
		},
		-- lsp
		{
			"<leader>vca",
			"<cmd>lua vim.lsp.buf.code_action()<CR>",
			desc = "Code actions",
		},
		{
			"gD",
			"<cmd>lua Snacks.picker.lsp_declarations()<CR>",
			desc = "Goto Definition",
		},
		{
			"gd",
			"<cmd>lua Snacks.picker.lsp_definitions()<CR>",
			desc = "Goto Definition",
		},
		{
			"<leader>gd",
			"<cmd>lua Snacks.picker.lsp_definitions()<CR>",
			desc = "Goto Definition",
		},
		{
			"<leader>gr",
			"<cmd>lua Snacks.picker.lsp_references()<CR>",
			nowait = true,
			desc = "References",
		},
		{
			"<leader>gi",
			"<cmd>lua Snacks.picker.lsp_implementations()<CR>",
			desc = "Goto Implementation",
		},
		{
			"<leader>gt",
			"<cmd>lua Snacks.picker.lsp_type_definitions()<CR>",
			desc = "Goto T[y]pe Definition",
		},
		{
			"<leader>ol",
			"<cmd>lua Snacks.picker.lsp_symbols()<CR>",
			desc = "LSP Symbols",
		},
	},

	-- 					header = [[
	--            ½ÌnóÏLóÌ@C@¢3™fkÿêEEXßãÛqXÅWÄÀŽÀKEÀRqXgAÖñbTxOçó£úCòs½Có33LÍVnö@óÍ±±V©Ì@C@¢¼òòó±3Lu¼CJì‡±¤IVÌvz¤¢3fšU9áÞDÿÿ€gþWXþÊÆŒR$dêAAåÏ}–“¬„::°’”!»°
	--          ’^VwC3òssòn¤@xhÙêWD?­;—i+³:`¨;ª*ív)“–ï2ÞÕÄÂËMŒÉÂÀëewLC0±snçù¢‰Ìz±ÍÏÏVC±óóóÌLCöVÍzƒƒuC3sƒ%rojlí¼üTýAÉÑŒÊÁœÞÝµv“              vÕKw>‹›|¦^³:„}‰^’
	--      ³­  |j±00C¤uY©¾®ðÄÃ¶`  ~¡¬°‘ ¸°­      ²*[+”’       ¨†ÖËÆÆÃd®T±@óLLs3™Ïö¼nJòuóöóLuösÌòÌz¢¢I¤‰£óOûFqÉÉEåi·                   ¨      ›dÓ0*‘¸‹°ˆ¹{£j|  ­³
	--      ‘  «äÒ¼cÏCòyeâËÈÖ+`·|}<‡Y4eÒkú=%@óI¦’      ‘”×l{¬!/?(—°››¬žpþœdŸyL@Ï0@Ïöwö£Ìóù2ös0½J6e9¥ÜßpQHèh9Yª       –”‹·‚ì|    ¨  ´`    ¨::·   ‚äµ¿+~ˆ„“ª9Òä«  ‘
	--     :  LÓ®¡ó½0§¥ÄÉá   ”[>[^’       ;º/=ct‡wfµòr1}“¨       ‘°²:’ˆ …¹0Ù€qmÇçsLòoóó‡uÍ¢Ïów}º†Vl°­›˜          ¹lí()º                           fGw?‚‹”¡˜¡®ÓL  :
	--     ‹ u$ú%–%ôFAû;;¸ˆ‘    ¸~íOhñ¥ñàÏº              `‘’¸     ``·’º„¦“ˆ­°  óYCw¢@ÏC©2CcnúÏ&¬|½¡(}z†’¨ªÙÔÙwtI   ˆ¨                               aÝ†/¹›°–%ú$u ‹
	--     › Z§uì*ÎåÖ“  …°ªÏÙæÑÈÅÅHêmßmÐQŒÑÑÆÆÆÊË8UY‰s±2ó>/{>}+«–’˜· ´’º³¬{¿î%£kï{J½½±@óòòöòòn©¢7)“²~º:³³                 ’¦£SÝûGAÚéøÔé8êENËÈEŠõ‘    ¢™i+³5*ìu§Z ›
	--    ­ ³äõ±w¬õz  ~u¶ËÈþ$ÿŸž5üó¢I±l}÷(>ïíƒÌ&¥ŠgÕ€A€Ûp8¶ÖŸÇZÿbà9LJ)³”¯I£i0z¼óC£Íns±Ïuc¤‰Ïj¿ÍV<)L×¯ª­›  …     ³ÌûåâDýÕßÚÚýäeSŸŸûOY¤cIvrò¼zí‡OPFy;   ¬¢²}!¬w±õä³ ­
	--    ˆ‘‡LóC¢lÍ¿“©mÔëx£±nno%‡©ô4ô2çe64wVL±3=+!„++}|³¡?¤}×JÏ™£ôTà$ëPülïi?– •©2©£VönÍwÍLÏCu½a2I|—“~c÷¹’’·¸³öàmâ§f‰—¡„ª¡¿i/‡×ì—÷)[>7l»¯|÷÷«„“<†í©9Z4»~›²)Cl¢CóL‡‘ˆ
	--   ;´ oŸÍvöw±LÍóLÍ0ò†<nVhýe%¤>²–lŠãt=ˆ         ´˜(ÚË#ðÝÏ*+*¼í>òôVÏLótt¢¢s3óçç™Tùuuz±±Jó¼?[(>}“; n¥&3ÎüJ?;  ¹hÈŒÑØŒËáãŠÖêÆÑÅËÆÐ÷´¨­°„?ó¬¡}ªª“º³°­;)+|JwövÍŸo ´;
	--   °…¨7µu½‰¢¤u¼n½v!/¦º•¢;   7¤ò)ˆ     zÆÆ ëà`         wÔåÎCµ®±çüù&wLÏsòuÏ£óÏx4x5úI¼Ì¤i‰u}}•«»’¸‚žôC¢©¦ ˆSÃÆÆþ0×                Í{  ‘„!¯—:’³^!¹~ª‹º”¯‰¢‰½uµ7¨…°
	--   °¸˜ƒÓ©0¤Jzƒc«ª%½3ež@  —»…      ’²jJ)˜   :Í¶g³ MÐ¨ ´÷ª|=v³‚„ö[|+ì‡‰£VóÏYö¢¤öYôÎ±zösz3J«»=>~²‘´dD½¹¦CÖWQD  :  ùÆ#·…!U¤  ‚            ·¹’ˆ  `;‘›’¹²¸3J¤0©Óƒ˜¸°
	--  ‘˜ ;3Î3u‰‡‰Ïü¤«÷¡CÜo       ; ‘Æœ  ‘¯;  ›GQL¯[  QþÃMŒÀ‰  >ô©¼ÍaP¾&cj%ƒsLÏ¢óCCöYL0Ìüso3¼/÷i!º^¸ ÏŸÌ)nD®¡     — àŽŽ·  ~6ëð^ˆ»Z‡–      …  ²²‚°¡º‘‹º•^º£‡‰u3Î3; ˜
	--   ¸”!ùž3‡îrÌƒI½¾5=         …« LŒËM4¸           OÆœ4)‹³OáÚ§³ÚÁeOOŸÎ0wuzuó‰óÌ3±½Io‡CVl×‰u?|ì¡•J› DèøØx^ …ëÆÆÆÌ Íú      Ì×º  jãDpü˜`         `‚:›››³—„2rî‡3žù!”¸
	--  … ³ªYŸò¤¼‡™ü2Ìs=0špGÙ§ùY0khZS„­;”ýÊÆÆÆŒŽÜøâgXF¯   ˆ¦~¸‘;–  zTy3VL0™óuö±Ï±½‰¢ö±L@óöírö½¦}cª—„‹{dP%   ›…       *¢6àSO7º¯I  bEÿK€ûD{—‹ˆ`  `~›‹›:‚›²/›@‡¼¤òŸYª³
	--  · ««ÍyY@V‰£wVç9µõa5xŸÎefv=v†² ¨ª¿ò   “„ªrˆ´›¨ ×©ûÿÀKBÈÈáDs©Ùõù3ùÌ0VotöÍ3Vn‰½òs‰ÌC@J%¢‰¬^¯^»ª“ºñ§§ùâŒŒMÈKŽÄÐh©ï–    ›•&á‘†k÷`     !ùž±ws%­ˆ;˜;—ª–ª”n‰V@YyÍ««
	--  ´˜[iuôù¢ƒ½±V¢Lúú2w&0üaV33uv<ƒIç‰n|>ôj«¯{(={~fdÚøÐëùoi!{ÌhPbT4úwLü±±¢su¢‰¢‡zöLÏuzInCr>ï•^÷¯÷÷~ JE¥2UÎxOxüÏò‡wáždÉÇV3*   –(”—‹:‹ ­%v[0§<­/‡7z%»°˜:¹°ò½ƒ¢ùôui[˜
	-- ‘‚‘¿¿V4üz¢Côú±3ÍCóÍ22LV±©0&w¢3¾V±±>úSC±CY5½*¦÷(¦!~°¬ìÌ¾ôÏLL00£aú£LÏ½öL3@¢ö£0utò¼JIònƒ[*{+¬—^“÷: <¥yt*|¬[‰ÌePÝñ0©V0DgÉÂÃ#$åï’<§Eû°‚  ‚˜…°‹v9òö©YÌ<³²¢C¢zü4V¿¿‘
	--  ›³;’4üülL‡C©ççwçü2©©ó¢sVwaÌ£úYÏLY5O±0wÍYYüµµkxõ6Te®ŸúÍx©©üVn@@ööC3zuòò‡‰¼jj%‡CÍC02CÏ>+†)¦|”„¡«” )Ö¾©ù©óór•÷¡÷uöì»«»[¼v<=rçÍ*«¯»¿[ïï¯›ÌÖ©¿~³~¦>iì%ì¼‡Llüü4’;³
	--                 ]],
	opts = function()
		local splash = require("milli").load({ splash = "foo", loop = true })

		return {
			dashboard = { -- startup screen options
				enabled = true,
				preset = {
					header = table.concat(splash.frames[1], "\n"),
				},
				sections = {
					{ section = "header", padding = 1 },
					{ padding = 1, gap = 1 }, -- prevents animation stuttering
					{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
					{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
					{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
					{ section = "startup" },
				},
			},
			-- 			dashboard = {
			-- 				enabled = true,
			-- 				width = 60,
			-- 				row = nil,
			-- 				col = nil,
			-- 				pane_gap = 4, -- empty columns between vertical panes
			-- 				autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
			-- 				preset = {
			-- 					pick = nil,
			-- 					keys = {
			-- 						{
			-- 							icon = " ",
			-- 							key = "f",
			-- 							desc = "Find File",
			-- 							action = ":lua Snacks.dashboard.pick('files')",
			-- 						},
			-- 						{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
			-- 						{
			-- 							icon = " ",
			-- 							key = "g",
			-- 							desc = "Find Text",
			-- 							action = ":lua Snacks.dashboard.pick('live_grep')",
			-- 						},
			-- 						{
			-- 							icon = " ",
			-- 							key = "r",
			-- 							desc = "Recent Files",
			-- 							action = ":lua Snacks.dashboard.pick('oldfiles')",
			-- 						},
			-- 						{
			-- 							icon = " ",
			-- 							key = "c",
			-- 							desc = "Config",
			-- 							action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
			-- 						},
			-- 						{
			-- 							icon = "󰒲 ",
			-- 							key = "L",
			-- 							desc = "Lazy",
			-- 							action = ":Lazy",
			-- 							enabled = package.loaded.lazy ~= nil,
			-- 						},
			-- 						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
			-- 					},
			-- 					header = [[
			--            ½ÌnóÏLóÌ@C@¢3™fkÿêEEXßãÛqXÅWÄÀŽÀKEÀRqXgAÖñbTxOçó£úCòs½Có33LÍVnö@óÍ±±V©Ì@C@¢¼òòó±3Lu¼CJì‡±¤IVÌvz¤¢3fšU9áÞDÿÿ€gþWXþÊÆŒR$dêAAåÏ}–“¬„::°’”!»°
			--          ’^VwC3òssòn¤@xhÙêWD?­;—i+³:`¨;ª*ív)“–ï2ÞÕÄÂËMŒÉÂÀëewLC0±snçù¢‰Ìz±ÍÏÏVC±óóóÌLCöVÍzƒƒuC3sƒ%rojlí¼üTýAÉÑŒÊÁœÞÝµv“              vÕKw>‹›|¦^³:„}‰^’
			--      ³­  |j±00C¤uY©¾®ðÄÃ¶`  ~¡¬°‘ ¸°­      ²*[+”’       ¨†ÖËÆÆÃd®T±@óLLs3™Ïö¼nJòuóöóLuösÌòÌz¢¢I¤‰£óOûFqÉÉEåi·                   ¨      ›dÓ0*‘¸‹°ˆ¹{£j|  ­³
			--      ‘  «äÒ¼cÏCòyeâËÈÖ+`·|}<‡Y4eÒkú=%@óI¦’      ‘”×l{¬!/?(—°››¬žpþœdŸyL@Ï0@Ïöwö£Ìóù2ös0½J6e9¥ÜßpQHèh9Yª       –”‹·‚ì|    ¨  ´`    ¨::·   ‚äµ¿+~ˆ„“ª9Òä«  ‘
			--     :  LÓ®¡ó½0§¥ÄÉá   ”[>[^’       ;º/=ct‡wfµòr1}“¨       ‘°²:’ˆ …¹0Ù€qmÇçsLòoóó‡uÍ¢Ïów}º†Vl°­›˜          ¹lí()º                           fGw?‚‹”¡˜¡®ÓL  :
			--     ‹ u$ú%–%ôFAû;;¸ˆ‘    ¸~íOhñ¥ñàÏº              `‘’¸     ``·’º„¦“ˆ­°  óYCw¢@ÏC©2CcnúÏ&¬|½¡(}z†’¨ªÙÔÙwtI   ˆ¨                               aÝ†/¹›°–%ú$u ‹
			--     › Z§uì*ÎåÖ“  …°ªÏÙæÑÈÅÅHêmßmÐQŒÑÑÆÆÆÊË8UY‰s±2ó>/{>}+«–’˜· ´’º³¬{¿î%£kï{J½½±@óòòöòòn©¢7)“²~º:³³                 ’¦£SÝûGAÚéøÔé8êENËÈEŠõ‘    ¢™i+³5*ìu§Z ›
			--    ­ ³äõ±w¬õz  ~u¶ËÈþ$ÿŸž5üó¢I±l}÷(>ïíƒÌ&¥ŠgÕ€A€Ûp8¶ÖŸÇZÿbà9LJ)³”¯I£i0z¼óC£Íns±Ïuc¤‰Ïj¿ÍV<)L×¯ª­›  …     ³ÌûåâDýÕßÚÚýäeSŸŸûOY¤cIvrò¼zí‡OPFy;   ¬¢²}!¬w±õä³ ­
			--    ˆ‘‡LóC¢lÍ¿“©mÔëx£±nno%‡©ô4ô2çe64wVL±3=+!„++}|³¡?¤}×JÏ™£ôTà$ëPülïi?– •©2©£VönÍwÍLÏCu½a2I|—“~c÷¹’’·¸³öàmâ§f‰—¡„ª¡¿i/‡×ì—÷)[>7l»¯|÷÷«„“<†í©9Z4»~›²)Cl¢CóL‡‘ˆ
			--   ;´ oŸÍvöw±LÍóLÍ0ò†<nVhýe%¤>²–lŠãt=ˆ         ´˜(ÚË#ðÝÏ*+*¼í>òôVÏLótt¢¢s3óçç™Tùuuz±±Jó¼?[(>}“; n¥&3ÎüJ?;  ¹hÈŒÑØŒËáãŠÖêÆÑÅËÆÐ÷´¨­°„?ó¬¡}ªª“º³°­;)+|JwövÍŸo ´;
			--   °…¨7µu½‰¢¤u¼n½v!/¦º•¢;   7¤ò)ˆ     zÆÆ ëà`         wÔåÎCµ®±çüù&wLÏsòuÏ£óÏx4x5úI¼Ì¤i‰u}}•«»’¸‚žôC¢©¦ ˆSÃÆÆþ0×                Í{  ‘„!¯—:’³^!¹~ª‹º”¯‰¢‰½uµ7¨…°
			--   °¸˜ƒÓ©0¤Jzƒc«ª%½3ež@  —»…      ’²jJ)˜   :Í¶g³ MÐ¨ ´÷ª|=v³‚„ö[|+ì‡‰£VóÏYö¢¤öYôÎ±zösz3J«»=>~²‘´dD½¹¦CÖWQD  :  ùÆ#·…!U¤  ‚            ·¹’ˆ  `;‘›’¹²¸3J¤0©Óƒ˜¸°
			--  ‘˜ ;3Î3u‰‡‰Ïü¤«÷¡CÜo       ; ‘Æœ  ‘¯;  ›GQL¯[  QþÃMŒÀ‰  >ô©¼ÍaP¾&cj%ƒsLÏ¢óCCöYL0Ìüso3¼/÷i!º^¸ ÏŸÌ)nD®¡     — àŽŽ·  ~6ëð^ˆ»Z‡–      …  ²²‚°¡º‘‹º•^º£‡‰u3Î3; ˜
			--   ¸”!ùž3‡îrÌƒI½¾5=         …« LŒËM4¸           OÆœ4)‹³OáÚ§³ÚÁeOOŸÎ0wuzuó‰óÌ3±½Io‡CVl×‰u?|ì¡•J› DèøØx^ …ëÆÆÆÌ Íú      Ì×º  jãDpü˜`         `‚:›››³—„2rî‡3žù!”¸
			--  … ³ªYŸò¤¼‡™ü2Ìs=0špGÙ§ùY0khZS„­;”ýÊÆÆÆŒŽÜøâgXF¯   ˆ¦~¸‘;–  zTy3VL0™óuö±Ï±½‰¢ö±L@óöírö½¦}cª—„‹{dP%   ›…       *¢6àSO7º¯I  bEÿK€ûD{—‹ˆ`  `~›‹›:‚›²/›@‡¼¤òŸYª³
			--  · ««ÍyY@V‰£wVç9µõa5xŸÎefv=v†² ¨ª¿ò   “„ªrˆ´›¨ ×©ûÿÀKBÈÈáDs©Ùõù3ùÌ0VotöÍ3Vn‰½òs‰ÌC@J%¢‰¬^¯^»ª“ºñ§§ùâŒŒMÈKŽÄÐh©ï–    ›•&á‘†k÷`     !ùž±ws%­ˆ;˜;—ª–ª”n‰V@YyÍ««
			--  ´˜[iuôù¢ƒ½±V¢Lúú2w&0üaV33uv<ƒIç‰n|>ôj«¯{(={~fdÚøÐëùoi!{ÌhPbT4úwLü±±¢su¢‰¢‡zöLÏuzInCr>ï•^÷¯÷÷~ JE¥2UÎxOxüÏò‡wáždÉÇV3*   –(”—‹:‹ ­%v[0§<­/‡7z%»°˜:¹°ò½ƒ¢ùôui[˜
			-- ‘‚‘¿¿V4üz¢Côú±3ÍCóÍ22LV±©0&w¢3¾V±±>úSC±CY5½*¦÷(¦!~°¬ìÌ¾ôÏLL00£aú£LÏ½öL3@¢ö£0utò¼JIònƒ[*{+¬—^“÷: <¥yt*|¬[‰ÌePÝñ0©V0DgÉÂÃ#$åï’<§Eû°‚  ‚˜…°‹v9òö©YÌ<³²¢C¢zü4V¿¿‘
			--  ›³;’4üülL‡C©ççwçü2©©ó¢sVwaÌ£úYÏLY5O±0wÍYYüµµkxõ6Te®ŸúÍx©©üVn@@ööC3zuòò‡‰¼jj%‡CÍC02CÏ>+†)¦|”„¡«” )Ö¾©ù©óór•÷¡÷uöì»«»[¼v<=rçÍ*«¯»¿[ïï¯›ÌÖ©¿~³~¦>iì%ì¼‡Llüü4’;³
			--                 ]],
			-- 					-- 				header = [[
			-- 					-- ████████╗██╗  ██╗███████╗    ██╗    ██╗ ██████╗ ██████╗ ██╗     ██████╗
			-- 					-- ╚══██╔══╝██║  ██║██╔════╝    ██║    ██║██╔═══██╗██╔══██╗██║     ██╔══██╗
			-- 					--    ██║   ███████║█████╗      ██║ █╗ ██║██║   ██║██████╔╝██║     ██║  ██║
			-- 					--    ██║   ██╔══██║██╔══╝      ██║███╗██║██║   ██║██╔══██╗██║     ██║  ██║
			-- 					--    ██║   ██║  ██║███████╗    ╚███╔███╔╝╚██████╔╝██║  ██║███████╗██████╔╝
			-- 					--    ╚═╝   ╚═╝  ╚═╝╚══════╝     ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝
			-- 					--                    ██╗███████╗    ██╗   ██╗ ██████╗ ██╗   ██╗██████╗ ███████╗
			-- 					--                    ██║██╔════╝    ╚██╗ ██╔╝██╔═══██╗██║   ██║██╔══██╗██╔════╝
			-- 					--                    ██║███████╗     ╚████╔╝ ██║   ██║██║   ██║██████╔╝███████╗
			-- 					--                    ██║╚════██║      ╚██╔╝  ██║   ██║██║   ██║██╔══██╗╚════██║
			-- 					--                    ██║███████║       ██║   ╚██████╔╝╚██████╔╝██║  ██║███████║██╗██╗██╗
			-- 					--                    ╚═╝╚══════╝       ╚═╝    ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝╚═╝╚═╝
			-- 					--                                 ]],
			-- 				},
			-- 				sections = {
			-- 					{ section = "header" },
			-- 					{ section = "keys", gap = 1, padding = 1 },
			-- 					{ section = "startup", padding = 1 },
			-- 					{
			-- 						align = "center",
			-- 						footer = "♍︎",
			-- 					},
			-- 				},
			-- 			},
			undo = {
				win = {
					preview = { wo = { number = false, relativenumber = false, signcolumn = "no" } },
					input = {
						keys = {
							["<C-y>"] = { "yank_add", mode = { "n", "i" } },
							["<s-y>"] = { "yank_del", mode = { "n", "i" } },
						},
					},
				},
				actions = {
					yank_add = { action = "yank", field = "added_lines" },
					yank_del = { action = "yank", field = "removed_lines" },
				},
				icons = { tree = { last = "┌╴" } }, -- the tree is upside down
				diff = {
					ctxlen = 4,
					ignore_cr_at_eol = true,
					ignore_whitespace_change_at_eol = true,
					indent_heuristic = true,
				},
			},
			bigfile = { enabled = true },
			explorer = { enabled = false },
			indent = {
				enabled = true,
				animate = {
					enabled = false,
				},
				filter = function(buf)
					return vim.g.snacks_indent ~= false
						and vim.b[buf].snacks_indent ~= false
						and vim.bo[buf].buftype == ""
						and vim.bo[buf].filetype ~= "markdown"
				end,
			},

			input = { enabled = true },

			picker = {
				enabled = true,
				regex = true,
			},

			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			scratch = { enabled = true },
			gh = { enabled = true },
			layout = { enabled = true },
			image = {
				enabled = false,
			},
			statuscolumn = { enabled = true },
			rename = { enabled = true },
			win = { enabled = true },
			lazygit = {
				configure = true,
			},
		}
	end,

	config = function(_, opts)
		require("snacks").setup(opts)
		require("milli").snacks({ splash = "foo", loop = true })
	end,
}
