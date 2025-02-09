class Location {
    private int aisle;
    private int shelf;
    private int bin;
    public Location(int aisle, int shelf, int bin) {
        this.aisle = aisle;
        this.shelf = shelf;
        this.bin = bin;
    }
    @Override
    public String toString() {
        return "Aisle: " + aisle + ", Shelf: " + shelf + ", Bin: " + bin;
    }
}
