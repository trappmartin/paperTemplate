filename=paper

all: 
	pdflatex ${filename}.tex
	bibtex ${filename}
	pdflatex ${filename}.tex

pdf:
	pdflatex ${filename}.tex

clean:
	rm -f ${filename}.{ps,pdf,log,aux,out,dvi,bbl,blg}

submission:
	gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dPrinted=false -dFirstPage=1 -dLastPage=13 -sOutputFile=submission.pdf ${filename}.pdf

appendix:
	gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dPrinted=false -dFirstPage=14 -sOutputFile=supplement.pdf ${filename}.pdf

supplementary:
	gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dPrinted=false -dFirstPage=14 -sOutputFile=supplement.pdf ${filename}.pdf
	rm -f supplement.zip
	zip supplement.zip 'supplement.pdf'
	cp -rv ../codes/supplement_codes codes
	zip -r supplement.zip codes/
	rm -rf codes

arxiv:
	rm -f arxiv.zip
	./stripcomments.pl ${filename}.tex > arxiv.tex
	cp article.bbl arxiv.bbl
	zip arxiv.zip 'arxiv.tex' 'arxiv.bbl' 'neurips_2021.sty'
	zip -r arxiv.zip fig -i 'fig/*.tex'
	zip -r arxiv.zip fig -i 'fig/*.png'
	zip -r arxiv.zip img -i 'img/*.tex'
	zip -r arxiv.zip img -i 'img/*.png'
	zip -r arxiv.zip tbl -i 'tbl/*.tex'
