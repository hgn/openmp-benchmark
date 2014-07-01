GNUPLOT_FILES = $(wildcard *.gpi)
PNG_OBJ = $(patsubst %.gpi,%.png,  $(GNUPLOT_FILES))
PDF_OBJ = $(patsubst %.gpi,%.pdf,  $(GNUPLOT_FILES))

all: $(PDF_OBJ)
png: $(PNG_OBJ)

eps:
	@ echo "compillation of "$<
	@gnuplot parallelization.gpi

%.pdf: eps
	@echo "conversion in pdf format"
	@epstopdf --outfile=parallelization.pdf parallelization.eps
	@epstopdf --outfile=parallelization-color.pdf parallelization-color.eps
	@echo "end"

%.png: %.eps
	@echo "conversion in png format"
	@convert -density 300 $< $*.png 
	@echo "end"

preview: all
	for i in $$(ls *.pdf); do xpdf -fullscreen $$i ; done

clean:
	@echo "cleaning ..."
	@rm -rf *.eps *.png *.pdf
