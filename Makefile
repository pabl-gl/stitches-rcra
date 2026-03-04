# Pablo García López pablo.glopez@udc.es
# Ansur Lopez Braña mail

EXAMPLES_DIR = examples
ENCODINGS_DIR = encodings
SOLUTIONS_DIR = solutions

DOMAINS    = $(wildcard $(EXAMPLES_DIR)/dom*.txt)
ENCODINGS  = $(patsubst $(EXAMPLES_DIR)/%.txt, $(ENCODINGS_DIR)/%.lp, $(DOMAINS))
SOLUTIONS  = $(patsubst $(EXAMPLES_DIR)/%.txt, $(SOLUTIONS_DIR)/sol%.txt, $(DOMAINS))

all: encode solve

encode: $(ENCODINGS)
	@echo "=== Codificación completada ==="

$(ENCODINGS_DIR)/%.lp: $(EXAMPLES_DIR)/%.txt
	@mkdir -p $(ENCODINGS_DIR)
	@echo "Codificando: $<"
	@python3 encode.py $< $@

solve: $(SOLUTIONS)
	@echo "=== Resolución completada ==="

$(SOLUTIONS_DIR)/sol%.txt: $(ENCODINGS_DIR)/%.lp stitches.lp
	@mkdir -p $(SOLUTIONS_DIR)
	@echo "Resolviendo: $<"
	@python3 decode.py stitches.lp $< $@
	@if [ -f $(EXAMPLES_DIR)/$(notdir $@) ]; then \
		if diff $@ $(EXAMPLES_DIR)/$(notdir $@) > /dev/null; then \
			echo "$* CORRECTA"; \
		else \
			echo "$* DIFIERE de la esperada"; \
		fi; \
	fi

solve_%: $(ENCODINGS_DIR)/%.lp stitches.lp
	@mkdir -p $(SOLUTIONS_DIR)
	@echo "Resolviendo: $<"
	@python3 decode.py stitches.lp $< $(SOLUTIONS_DIR)/sol$*.txt
	@if [ -f $(EXAMPLES_DIR)/sol$*.txt ]; then \
		if diff $(SOLUTIONS_DIR)/sol$*.txt $(EXAMPLES_DIR)/sol$*.txt > /dev/null; then \
			echo "dom$* CORRECTA"; \
		else \
			echo "dom$* DIFIERE de la esperada"; \
		fi; \
	fi

clean:
	@rm -rf $(ENCODINGS_DIR) $(SOLUTIONS_DIR)
	@echo "Limpieza completada."


.PHONY: all encode solve clean
