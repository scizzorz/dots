Vim�UnDo� ���qc� ���W�?���b��Q8Я���e�A�   2   		for b in bg:   '         5       5   5   5    Q,�    _�                             ����                                                                                                                                                                                                                                                                                                                                                             Q,I     �   *   ,          ,			row += highlight(fg = f, bg = b + offset)�   "   $          #		row += highlight(bg = b + offset)�                ?	return '\033[%dm\033[%dm %2d/%2d \033[0m' % (fgc, bgc, fg, bg)�                3		return '\033[%dm   /%2d \033[0m' % (bgc - 10, bg)�                9	if bg == None: # print a foreground and blank background�                			bgc = bg + 40�                			bgc = bg + 92�                		if bg > 7:�                	if bg != None:�                $def highlight(fg = None, bg = None):5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             Q,L     �   *   ,          4			row += highlight(fg = f, background = b + offset)�                O	return '\033[%dm\033[%dm %2d/%2d \033[0m' % (fgc, backgroundc, fg, background)�                4	if fg == None: # print a background as a foreground�                .		return '\033[%dm %2d/   \033[0m' % (fgc, fg)�   	             			fgc = fg + 30�      	          			fgc = fg + 82�                		if fg > 7:�                	if fg != None:�                ,def highlight(fg = None, background = None):5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             Q,U     �                _	return '\033[%dm\033[%dm %2d/%2d \033[0m' % (foregroundc, backgroundc, foreground, background)�                C		return '\033[%dm   /%2d \033[0m' % (backgroundc - 10, background)�                 			backgroundc = background + 40�                 			backgroundc = background + 925�_�                            ����                                                                                                                                                                                                                                                                                                                                                             Q,Z     �                b	return '\033[%dm\033[%dm %2d/%2d \033[0m' % (foregroundc, background_esc, foreground, background)�                >		return '\033[%dm %2d/   \033[0m' % (foregroundc, foreground)�   	              			foregroundc = foreground + 30�      	           			foregroundc = foreground + 825�_�                    '       ����                                                                                                                                                                                                                                                                                                                                                             Q,m     �   &   (   5      	for f in foreground:5�_�                    '       ����                                                                                                                                                                                                                                                                                                                                                             Q,v     �   &   (   5      	for fg_it in foreground:5�_�                    '       ����                                                                                                                                                                                                                                                                                                                                                             Q,v     �   &   (   5      	for f_it in foreground:5�_�      	              '       ����                                                                                                                                                                                                                                                                                                                                                             Q,v     �   &   (   5      	for fit in foreground:5�_�      
           	   '       ����                                                                                                                                                                                                                                                                                                                                                             Q,v    �   &   (   5      	for ft in foreground:5�_�   	              
   )       ����                                                                                                                                                                                                                                                                                                                                                             Q,�     �   (   *   5      		row += highlight(f)5�_�   
                 )       ����                                                                                                                                                                                                                                                                                                                                                             Q,�     �   (   *   5    5�_�                    *       ����                                                                                                                                                                                                                                                                                                                                                             Q,�     �   *   ,   7      		�   *   ,   6    5�_�                    -       ����                                                                                                                                                                                                                                                                                                                                                             Q,�     �   -   /   7    5�_�                    +       ����                                                                                                                                                                                                                                                                                                                                                             Q,�     �   *   ,   8      		j5�_�                    +        ����                                                                                                                                                                                                                                                                                                                                                             Q,�     �   *   ,   8      		5�_�                    +        ����                                                                                                                                                                                                                                                                                                                                                             Q,�     �   *   ,   8      	5�_�                    #        ����                                                                                                                                                                                                                                                                                                                                                             Q,�     �   #   %   8    5�_�                    #       ����                                                                                                                                                                                                                                                                                                                                                             Q,�     �   "   $   9    5�_�                    "       ����                                                                                                                                                                                                                                                                                                                                                             Q,�     �   !   #   :    5�_�                    $        ����                                                                                                                                                                                                                                                                                                                                                             Q,�     �   #   $           5�_�                    "        ����                                                                                                                                                                                                                                                                                                                                                             Q,�     �   !   "           5�_�                    $        ����                                                                                                                                                                                                                                                                                                                                                             Q,�     �   #   $           5�_�                    +        ����                                                                                                                                                                                                                                                                                                                                                             Q,�     �   *   +           5�_�                    -        ����                                                                                                                                                                                                                                                                                                                                                             Q,�     �   ,   -           5�_�                    )        ����                                                                                                                                                                                                                                                                                                                                                             Q,�    �   (   )           5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             Q,�     �                e	return '\033[%dm\033[%dm %2d/%2d \033[0m' % (foreground_esc, background_esc, foreground, background)�                A		return '\033[%dm %2d/   \033[0m' % (foreground_esc, foreground)�   	             #			foreground_esc = foreground + 30�      	          #			foreground_esc = foreground + 825�_�                            ����                                                                                                                                                                                                                                                                                                                                                             Q,�     �                ]	return '\033[%dm\033[%dm %2d/%2d \033[0m' % (fg_esc, background_esc, foreground, background)�                F		return '\033[%dm   /%2d \033[0m' % (background_esc - 10, background)�                #			background_esc = background + 40�                #			background_esc = background + 925�_�                            ����                                                                                                                                                                                                                                                                                                                                                             Q,�     �   *   ,          <			row += highlight(foreground = f, background = b + offset)�   (   *          "		row += highlight(foreground = f)�   &   (          	for f in foreground:�                	foreground = range(16)�                U	return '\033[%dm\033[%dm %2d/%2d \033[0m' % (fg_esc, bg_esc, foreground, background)�                $	# print a foreground and background�                <	if foreground == None: # print a background as a foreground�                9		return '\033[%dm %2d/   \033[0m' % (fg_esc, foreground)�                A	if background == None: # print a foreground and blank background�   	             			fg_esc = foreground + 30�      	          			fg_esc = foreground + 82�                		if foreground > 7:�                	if foreground != None:�                9	# adjust the foreground color to the correct escape code�                4def highlight(foreground = None, background = None):5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             Q,�    �   *   ,          7			row += highlight(fg_id = f, background = b + offset)�   )   +          		for b in background:�   "   $          +		row += highlight(background = b + offset)�   !   #          	for b in background:�                	background = range(8)�                P	return '\033[%dm\033[%dm %2d/%2d \033[0m' % (fg_esc, bg_esc, fg_id, background)�                	# print a fg_id and background�                >		return '\033[%dm   /%2d \033[0m' % (bg_esc - 10, background)�                2	if fg_id == None: # print a background as a fg_id�                <	if background == None: # print a fg_id and blank background�                			bg_esc = background + 40�                			bg_esc = background + 92�                		if background > 7:�                	if background != None:�                9	# adjust the background color to the correct escape code�                /def highlight(fg_id = None, background = None):5�_�                    '       ����                                                                                                                                                                                                                                                                                                                                                             Q,�     �   &   (   5      	for f in fg_id:5�_�                     )       ����                                                                                                                                                                                                                                                                                                                                                             Q,     �   (   *   5      		row += highlight(fg_id = f)5�_�      !               +       ����                                                                                                                                                                                                                                                                                                                                                             Q,     �   *   ,   5      2			row += highlight(fg_id = f, bg_id = b + offset)5�_�       "           !   "       ����                                                                                                                                                                                                                                                                                                                                                             Q,     �   !   #   5      	for b in bg_id:5�_�   !   #           "   #       ����                                                                                                                                                                                                                                                                                                                                                             Q,     �   "   $   5      &		row += highlight(bg_id = b + offset)5�_�   "   $           #   *       ����                                                                                                                                                                                                                                                                                                                                                             Q,     �   )   +   5      		for b in bg_id:5�_�   #   %           $   +   )    ����                                                                                                                                                                                                                                                                                                                                                             Q,    �   *   ,   5      3			row += highlight(fg_id = fg, bg_id = b + offset)5�_�   $   '           %   "       ����                                                                                                                                                                                                                                                                                                                                                             Q,8     �   !   #   5      	for bg in bg_id:5�_�   %   (   &       '   #       ����                                                                                                                                                                                                                                                                                                                                                             Q,>     �   "   $   5      '		row += highlight(bg_id = bg + offset)5�_�   '   )           (   *       ����                                                                                                                                                                                                                                                                                                                                                             Q,@     �   )   +   5      		for bg in bg_id:5�_�   (   *           )   +   *    ����                                                                                                                                                                                                                                                                                                                                                             Q,C     �   *   ,   5      4			row += highlight(fg_id = fg, bg_id = bg + offset)5�_�   )   +           *   '       ����                                                                                                                                                                                                                                                                                                                                                             Q,N     �   &   (   5      	for fg in fg_id:5�_�   *   ,           +   )       ����                                                                                                                                                                                                                                                                                                                                                             Q,P     �   (   *   5      		row += highlight(fg_id = fg)5�_�   +   -           ,   +       ����                                                                                                                                                                                                                                                                                                                                                             Q,R    �   *   ,   5      8			row += highlight(fg_id = fg, bg_id = bg_cur + offset)5�_�   ,   .           -   "        ����                                                                                                                                                                                                                                                                                                                                                             Q,_    �   *   ,          <			row += highlight(fg_id = fg_cur, bg_id = bg_cur + offset)�   )   +          		for bg_cur in bg_id:�   (   *          "		row += highlight(fg_id = fg_cur)�   &   (          	for fg_cur in fg_id:�   "   $          +		row += highlight(bg_id = bg_cur + offset)�   !   #          	for bg_cur in bg_id:5�_�   -   /           .           ����                                                                                                                                                                                                                                                                                                                                                             Q,q    �   *   ,          2			row += highlight(fg_id = f, bg_id = b + offset)�   )   +          		for b in bg_id:�   (   *          		row += highlight(fg_id = f)�   &   (          	for f in fg_id:�   "   $          &		row += highlight(bg_id = b + offset)�   !   #          	for b in bg_id:�                	bg_id = range(8)�                	fg_id = range(16)�                K	return '\033[%dm\033[%dm %2d/%2d \033[0m' % (fg_esc, bg_esc, fg_id, bg_id)�                	# print a fg_id and bg_id�                9		return '\033[%dm   /%2d \033[0m' % (bg_esc - 10, bg_id)�                -	if fg_id == None: # print a bg_id as a fg_id�                4		return '\033[%dm %2d/   \033[0m' % (fg_esc, fg_id)�                2	if bg_id == None: # print a fg_id and blank bg_id�                			bg_esc = bg_id + 40�                			bg_esc = bg_id + 92�                		if bg_id > 7:�                	if bg_id != None:�                4	# adjust the bg_id color to the correct escape code�   	             			fg_esc = fg_id + 30�      	          			fg_esc = fg_id + 82�                		if fg_id > 7:�                	if fg_id != None:�                4	# adjust the fg_id color to the correct escape code�                *def highlight(fg_id = None, bg_id = None):5�_�   .   0           /   '   
    ����                                                                                                                                                                                                                                                                                                                                                             Q,�     �   &   (   5      	for f in fg:5�_�   /   1           0   "   
    ����                                                                                                                                                                                                                                                                                                                                                             Q,�     �   !   #   5      	for b in bg:5�_�   0   2           1   '   
    ����                                                                                                                                                                                                                                                                                                                                                             Q,�     �   &   (   5      	for f in foregrounds:5�_�   1   3           2          ����                                                                                                                                                                                                                                                                                                                                                             Q,�   	 �                	fg = range(16)   	bg = range(8)    5�_�   2   4           3          ����                                                                                                                                                                                                                                                                                                                                                             Q,�     �         2      	# first header5�_�   3   5           4   #       ����                                                                                                                                                                                                                                                                                                                                                             Q,�   
 �   "   $   2      	# first palette5�_�   4               5   '       ����                                                                                                                                                                                                                                                                                                                                                             Q,�    �   &   (   2      		for b in bg:5�_�   %           '   &   #       ����                                                                                                                                                                                                                                                                                                                                                             Q,<     �   "   $   5      +		row += highlight(bg_id = b_curg + offset)5��