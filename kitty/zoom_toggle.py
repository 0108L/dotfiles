#!/usr/bin/env python3
"""
zoom toggle
ref https://sw.kovidgoyal.net/kitty/kittens/custom/#using-kittens-to-script-kitty-without-any-terminal-ui
"""

def main(args):
    pass

from kittens.tui.handler import result_handler
@result_handler(no_ui=True)
def handle_result(args, answer, target_window_id, boss):
    tab = boss.active_tab
    if tab is not None:
        # do not switch to stack layout if we have only one window
        if len(tab.windows) > 1:
            if tab.current_layout.name == 'stack':
                tab.last_used_layout()
            else:
                tab.goto_layout('stack')

# from typing import List
# from kitty.boss import Boss
#
# def main(args: List[str]) -> str:
#     pass
#
# from kittens.tui.handler import result_handler
# @result_handler(no_ui=True)
# def handle_result(args: List[str], answer: str, target_window_id: int, boss: Boss) -> None:
#     tab = boss.active_tab
#     if tab is not None:
#         if tab.current_layout.name == 'stack':
#             tab.last_used_layout()
#         else:
#             tab.goto_layout('stack')
#             # boss.toggle_fullscreen()
