pdf: user2014.pdf
tex: user2014.tex

%.pdf: %.md
#	pandoc -t beamer -V theme=Warsaw --latex-engine=xelatex -o $@ $<
	pandoc -t beamer -V theme=cbs --latex-engine=xelatex -o $@ $<

%.tex: %.md
	pandoc -s -t beamer -V theme=cbs -o $@ $<

clean:
	rm -f docopt_pres.pdf docopt_pres.tex
